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
        let arView = ARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}
