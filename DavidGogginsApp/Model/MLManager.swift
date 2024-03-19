//
//  MLManager.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-19.
//

import Foundation
import CoreML
import ARKit

class MLManager {
    
    var classifier: HandPoseClassifier?
    
    init() {
        loadModel()
    }
    
    private func loadModel() {
        do {
            try classifier = HandPoseClassifier(configuration: MLModelConfiguration())
        } catch {
            print("Error loading model \(error)")
        }
    }
    
    func classifyFrame(frame: ARFrame) -> Classification? {
        // Get the keypoint array
        guard let keypointArray = extractKeyPointArrayFromImage(frame: frame) else {return nil}
        
        // Predict handpose (classify)
        let classification = classify(keypointArray: keypointArray)
        
        return classification
    }
    
    private func extractKeyPointArrayFromImage(frame: ARFrame) -> MLMultiArray? {
        // 1. Get image from frame
        let image = frame.capturedImage
        
        // 2. Define handpose request
        let handposeRequest = VNDetectHumanHandPoseRequest()
        handposeRequest.maximumHandCount = 1
        handposeRequest.revision = VNDetectHumanBodyPoseRequestRevision1
        
        // 3. Run the request
        let handler = VNImageRequestHandler(cvPixelBuffer: image)
        do {
            try handler.perform([handposeRequest])
        } catch {
            print("Error performing handpose request: \(error)")
            return nil
        }
        
        // 4. Handpose observation (access to keypointArray)
        guard let handPoses = handposeRequest.results, !handPoses.isEmpty else {return nil}
        do {
            let keypointArray = try handPoses.first?.keypointsMultiArray()
            return keypointArray
        } catch {
            print("Error getting keypoint array: \(error)")
            return nil
        }
    }
    private func classify(keypointArray: MLMultiArray) -> Classification? {
        guard let classifier = classifier else {return nil}
        do {
            let classification = try classifier.prediction(poses: keypointArray)
            
            // Get probability of classification
            guard let confidence = classification.labelProbabilities[classification.label] else {return nil}
            
            if(confidence > 0.9) {
                return mapClassificationStringValues(label: classification.label)
            } else {
                return nil
            }
            
        } catch {
            print("Error classifying: \(error)")
            return nil
        }
    }
    private func mapClassificationStringValues(label: String) -> Classification {
        switch label {
          case "Open":
            return .open
            
          case "Closed":
            return .close
            
          case "Background":
            return .background
            
        default:
            return .background
        }
    }
}

enum Classification {
    case open
    case close
    case background
}
