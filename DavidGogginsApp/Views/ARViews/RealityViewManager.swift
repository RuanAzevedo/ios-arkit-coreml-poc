//
//  RealityViewManager.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-19.
//

import Foundation
import RealityKit
import ARKit

class RealityViewManager: ObservableObject {
    
    static let shared = RealityViewManager()
    
    let arView = ARView(frame: .zero)
    var currentTextModel: ModelEntity?
    
    var currentHandPose: Classification? {
        didSet {
            
            if(oldValue == currentHandPose) {return}
            
            switch currentHandPose {
            case .open:
                playTextVideo()
            case .close:
                stopTextVideo()
            case .background:
                stopTextVideo()
            default:
                stopTextVideo()
            }
        }
    }
    
    @Published var arFaceAnchor: ARFaceAnchor?
    
    // Start FaceTracking
    func startARSession() {
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        arView.session.run(configuration)
    }
    
    func displayGoalInAR(goalText: String){
        // 1. Check if face anchor exists
        guard let arFaceAnchor = arFaceAnchor else {return}
        
        // 2. Remove current text
        removeCurrentTextModel()
        
        // 3. Place text on face
        placeTextOnFace(text: goalText, arFaceAnchor: arFaceAnchor)
    }
    private func placeTextOnFace(text: String, arFaceAnchor: ARFaceAnchor) {
        // 1. FaceAnchor Entity (anchors to the face)
        let faceAnchorEntity = AnchorEntity(anchor: arFaceAnchor)
        
        // 2. Create Box (Model Entity)
        currentTextModel = createTextModel(with: text)
        
        // 3. Set Text Position To Top Of Face
        setTextPosition(textModel: currentTextModel!, faceAnchor: arFaceAnchor)
        
        // 4. Attach Box to FaceAnchorEntity
        faceAnchorEntity.addChild(currentTextModel!)
        
        // 4. Add FaceAnchorEntity to ARView
        arView.scene.addAnchor(faceAnchorEntity)
    }
    private func createTextModel(with text: String) -> ModelEntity {
        // Mesh
        let textMesh = MeshResource.generateText(
            text,
            extrusionDepth: 0.01,
            font: .monospacedSystemFont(ofSize: 0.03, weight: .bold),
            alignment: .center
        )
        
        // Material
        let textMaterial = SimpleMaterial(color: .white, isMetallic: false)
        
        // Model Entity
        let modelEntity = ModelEntity(mesh: textMesh, materials: [textMaterial])
        
        return modelEntity
    }
    private func setTextPosition(textModel: ModelEntity, faceAnchor: ARFaceAnchor) {
        // 1. Offset values (x,y,z)
        let xOffset = faceAnchor.rightEyeTransform.position().x - 0.05
        let yOffset = faceAnchor.rightEyeTransform.position().y + 0.03
        let zOffset = faceAnchor.rightEyeTransform.position().z + 0.03
        
        let offset = SIMD3<Float>(x: xOffset, y: yOffset, z: zOffset)
        
        // 2. Set the text offset
        textModel.setPosition(offset, relativeTo: textModel.parent)
    }
    private func removeCurrentTextModel() {
        // Check if text exists
        guard let currentTextModel = currentTextModel else {return}
        
        // Remove text
        currentTextModel.removeFromParent()
    }
    
    // Play/Stop Text Video
    func playTextVideo() {
        guard let currentTextModel = currentTextModel else {
            return
        }
        
        // Change material to a video material (for textModel)
        VideoMaterialManager.shared.enableVideo(for: currentTextModel)
    }
    func stopTextVideo() {
        // Check if text exists
        guard let currentTextModel = currentTextModel else {
            return
        }
        
        // Change material to a simple material (for textModel)
        VideoMaterialManager.shared.disableVideo(for: currentTextModel)
    }
}

class Coordinator: NSObject, ARSessionDelegate {
    
    let mlManager = MLManager()
    var frameCounter = 0
    
    // On Anchor Added
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
                
        for anchor in anchors {
            // 1. Get Access to FaceAnchor
            guard let faceAnchor = anchor as? ARFaceAnchor else {return}
            
            RealityViewManager.shared.arFaceAnchor = faceAnchor
        }
        
    }
    
    // On New Frame
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        frameCounter+=1
        
        // Skipping every 5 frames
        if(frameCounter%5 == 0) {
            guard let classification = mlManager.classifyFrame(frame: frame) else {return}
            RealityViewManager.shared.currentHandPose = classification
        }
    }
    
}

extension matrix_float4x4 {
    func position() -> SIMD3<Float> {
        return SIMD3<Float>(columns.3.x, columns.3.y, columns.3.z)
    }
}
