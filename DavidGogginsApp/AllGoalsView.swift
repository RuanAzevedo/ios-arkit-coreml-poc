//
//  AllGoalsView.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-12.
//

import SwiftUI

struct AllGoalsView: View {
    
    @State private var allGoals: [Goal] = []
    
    var body: some View {
        VStack(alignment: .leading) {
           // Text
            Text("Your Goals")
                .font(.largeTitle.bold())
                .foregroundColor(Color("Accent"))
                .padding(.leading)
            
            // List View
            List {
                ForEach(allGoals, id: \.self) { goal in
                    // Goal View
                    ListRow(text: goal.goalText!)
                }
                .onDelete(perform: { indexSet in
                    // Delete logic
                    for index in indexSet {
                        let goalToDelete = allGoals[index]
                        PersistenceManager.shared.deleteGoal(goal: goalToDelete)
                        
                        // Delete it from goals array
                        allGoals.remove(at: index)
                    }
                })
            }
            .scrollContentBackground(.hidden)
            .background(Color("Secondary"))
        }
        .background(Color("Secondary"))
        .onAppear {
            // Load latest goals
            allGoals = PersistenceManager.shared.fetchGoals()
        }
    }
}

struct ListRow: View {
    let text: String
    
    var body: some View {
        Text(text)
            .listRowBackground(Color("Primary"))
            .foregroundColor(Color("Accent"))
            .font(.body.bold())
    }
}

#Preview {
    AllGoalsView()
}
