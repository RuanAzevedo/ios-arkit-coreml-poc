//
//  PersistanceManager.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-15.
//

import Foundation
import CoreData

class PersistenceManager {
    
    static let shared = PersistenceManager()
    
    private let container: NSPersistentContainer
    
    init() {
        // Load container
        container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading stores: \(error)")
            } else {
                print("Successfully loaded store")
            }
        }
    }
    
    // CRUD: Create new Goal Object
    func createGoal(text: String) {
        let newGoal = Goal(context: container.viewContext)
        newGoal.goalText = text
        
        // Commit: From context -> container (database)
        save()
    }
    
    // CRUD: Read all goals
    func fetchGoals() -> [Goal] {
        // Search criteria
        let request = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            let allGoals = try container.viewContext.fetch(request)
            return allGoals
        } catch {
            fatalError("Error fetching data \(error)")
        }
    }
    
    // CRUD: Delete
    func deleteGoal(goal: Goal) {
        container.viewContext.delete(goal)
        save()
    }
    
    // Commit To Database
    func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to database: \(error)")
        }
    }
    
    
}
