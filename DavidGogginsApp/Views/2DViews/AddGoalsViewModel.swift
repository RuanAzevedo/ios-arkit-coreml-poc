//
//  AddGoalsViewModel.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-19.
//

import Foundation

class AddGoalsViewModel: ObservableObject {
    
    @Published var inputText = ""
    
    // CRUD: Create
    func createGoal() {
        if(inputText != ""){
            PersistenceManager.shared.createGoal(text: inputText)
        }
    }
    
}
