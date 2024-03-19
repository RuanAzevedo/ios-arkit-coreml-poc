//
//  RealityViewManager.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-19.
//

import Foundation
import RealityKit
import ARKit

class RealityViewManager {
    
    static let shared = RealityViewManager()
    
    let arView = ARView(frame: .zero)
    
    // Start FaceTracking
    func startARSession() {
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        arView.session.run(configuration)
    }
    
    func placeTextOnFace(arFaceAnchor: ARFaceAnchor) {
        // 1. FaceAnchor Entity (anchors to the face)
        let faceAnchorEntity = AnchorEntity(anchor: arFaceAnchor)
        
        // 2. Create Box (Model Entity)
        let textModel = createTextModel(with: "David Goggins")
        
        // 3. Set Text Position To Top Of Face
        setTextPosition(textModel: textModel, faceAnchor: arFaceAnchor)
        
        // 4. Attach Box to FaceAnchorEntity
        faceAnchorEntity.addChild(textModel)
        
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
}

class Coordinator: NSObject, ARSessionDelegate {
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            // 1. Get Access to FaceAnchor
            guard let faceAnchor = anchor as? ARFaceAnchor else {return}
            
            // 2. Place Box Onto FaceAnchor
            RealityViewManager.shared.placeTextOnFace(arFaceAnchor: faceAnchor)
        }
        
    }
    
}

extension matrix_float4x4 {
    func position() -> SIMD3<Float> {
        return SIMD3<Float>(columns.3.x, columns.3.y, columns.3.z)
    }
}
