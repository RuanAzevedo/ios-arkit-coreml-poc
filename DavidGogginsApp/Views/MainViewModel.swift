//
//  MainViewModel.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-19.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var isAddGoalsViewShowing = false
    @Published var isAllGoalsViewShowing = false
    
    var allGoals = [
        "Thing bigger",
        "Action oftener",
        "Persevere longer"
    ]
    
    var currentGoal = 0
    
    func displayNextGoal() {
        // 1. Get next goal
        let nextGoal = getNextGoal()
        
        // 2. Display the goal on face
        RealityViewManager.shared.displayGoalInAR(goalText: nextGoal)
    }
    
    private func getNextGoal() -> String {
        let nextGoal = allGoals[currentGoal]
        
        // Append
        if(currentGoal < allGoals.count - 1) {
            currentGoal += 1
        } else {
            currentGoal = 0
        }
        
        return nextGoal
    }
    
}
