//
//  AllGoalsViewModel.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-19.
//

import Foundation

class AllGoalsViewModel: ObservableObject {
    
    @Published var allGoals: [Goal] = []
    
    func loadLatestGoals() {
        allGoals = PersistenceManager.shared.fetchGoals()
    }
    
    func deleteGoals(indexSet: IndexSet) {
        for index in indexSet {
            let goalToDelete = allGoals[index]
            PersistenceManager.shared.deleteGoal(goal: goalToDelete)
            
            // Delete it from goals array
            allGoals.remove(at: index)
        }
    }
    
}
