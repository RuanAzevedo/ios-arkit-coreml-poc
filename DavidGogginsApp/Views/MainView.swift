//
//  ContentView.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-12.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var mainViewModel = MainViewModel()
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            // ARView
            RealityView().ignoresSafeArea()
            
            // Buttons
            HStack(spacing: 20) {
                CircleButton(iconName: "plus") {
                    mainViewModel.isAddGoalsViewShowing = true
                }
                .popover(isPresented: $mainViewModel.isAddGoalsViewShowing) {
                    AddGoalsView(isViewShowing: $mainViewModel.isAddGoalsViewShowing)
                }
                
                CircleButton(iconName: "view.2d") {
                    // Show All Goals View
                    mainViewModel.isAllGoalsViewShowing = true
                }
                .popover(isPresented: $mainViewModel.isAllGoalsViewShowing) {
                    AllGoalsView()
                }
            }
        }
        .onAppear {
            RealityViewManager.shared.startARSession()
        }
    }
}

#Preview {
    MainView()
}
