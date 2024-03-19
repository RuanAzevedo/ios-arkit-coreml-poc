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
            RealityView()
                .ignoresSafeArea()
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded({ value in
                            if(value.translation.width > 0) {
                                // Dispay next goal
                                mainViewModel.displayNextGoal()
                            }
                        })
                )
            
            
            // Buttons
            HStack(spacing: 20) {
                CircleButton(iconName: "plus") {
                    mainViewModel.isAddGoalsViewShowing = true
                }
                .popover(isPresented: $mainViewModel.isAddGoalsViewShowing) {
                    AddGoalsView(isViewShowing: $mainViewModel.isAddGoalsViewShowing) {
                        // Fetch latests goals
                        mainViewModel.fetchLatestGoals()
                    }
                }
                
                CircleButton(iconName: "view.2d") {
                    // Show All Goals View
                    mainViewModel.isAllGoalsViewShowing = true
                }
                .popover(isPresented: $mainViewModel.isAllGoalsViewShowing) {
                    AllGoalsView()
                }
                
                // Dummy Button
                CircleButton(iconName: "video") {
                    RealityViewManager.shared.playTextVideo()
                }
                
                // Dummy Button
                CircleButton(iconName: "video.slash") {
                    RealityViewManager.shared.stopTextVideo()
                }
                
            }
        }
        .onAppear {
            
            // Fetch latests goals from database
            mainViewModel.fetchLatestGoals()
            
            // Starts the ARSession
            RealityViewManager.shared.startARSession()
        }
    }
}

#Preview {
    MainView()
}
