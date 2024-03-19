//
//  VideoMaterialManager.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-19.
//

import Foundation
import RealityKit
import AVFoundation

class VideoMaterialManager {
    
    static let shared = VideoMaterialManager()
    
    var playerItem: AVPlayerItem?
    var videoPlayer = AVPlayer()
    
    func enableVideo(for textModel: ModelEntity) {
        // 1. Create video material
        let videoMaterial = createVideoMaterial()
        
        // 2. Apple Video Material to TextModel
        textModel.model?.materials = [videoMaterial]
        
        // 3. Play the video
        playVideo()
    }
    func disableVideo(for textModel: ModelEntity) {
        let textMaterial = SimpleMaterial(color: .white, isMetallic: false)
        textModel.model?.materials = [textMaterial]
    }
    
    private func createVideoMaterial() -> VideoMaterial {
        // 1. Load video
        guard let videoUrl = Bundle.main.url(forResource: "VideoForText", withExtension: "mp4") else {
            fatalError("Cannot find video file")
        }
        let videoAsset = AVURLAsset(url: videoUrl)
        playerItem = AVPlayerItem(asset: videoAsset)
        
        // 2. Create material
        let videoMaterial = VideoMaterial(avPlayer: videoPlayer)
        
        // 3. return material
        return videoMaterial
    }
    private func playVideo() {
        videoPlayer.replaceCurrentItem(with: playerItem)
        videoPlayer.play()
    }
}
