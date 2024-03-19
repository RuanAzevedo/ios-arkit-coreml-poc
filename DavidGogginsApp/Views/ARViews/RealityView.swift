//
//  RealityView.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-12.
//

import Foundation
import SwiftUI
import RealityKit

struct RealityView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some ARView {
        RealityViewManager.shared.arView.session.delegate = context.coordinator
        
        return RealityViewManager.shared.arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}
