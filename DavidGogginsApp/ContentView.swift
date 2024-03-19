//
//  ContentView.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-12.
//

import SwiftUI

struct ContentView: View {
    
    @State var isAddGoalsViewShowing = false
    @State var isAllGoalsViewShowing = false
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            // ARView
            RealityView().ignoresSafeArea()
            
            // Buttons
            HStack(spacing: 20) {
                CircleButton(iconName: "plus") {
                    isAddGoalsViewShowing = true
                }
                .popover(isPresented: $isAddGoalsViewShowing) {
                    AddGoalsView(isViewShowing: $isAddGoalsViewShowing)
                }
                
                CircleButton(iconName: "view.2d") {
                    // Show All Goals View
                    isAllGoalsViewShowing = true
                }
                .popover(isPresented: $isAllGoalsViewShowing) {
                    AllGoalsView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
