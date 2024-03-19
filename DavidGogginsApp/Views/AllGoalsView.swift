//
//  AllGoalsView.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-12.
//

import SwiftUI

struct AllGoalsView: View {
    
    @ObservedObject var allGoalsViewModel = AllGoalsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
           // Text
            Text("Your Goals")
                .font(.largeTitle.bold())
                .foregroundColor(Color("Accent"))
                .padding(.leading)
            
            // List View
            List {
                ForEach(allGoalsViewModel.allGoals, id: \.self) { goal in
                    // Goal View
                    ListRow(text: goal.goalText!)
                }
                .onDelete(perform: { indexSet in
                    // Delete goals
                    allGoalsViewModel.deleteGoals(indexSet: indexSet)
                })
            }
            .scrollContentBackground(.hidden)
            .background(Color("Secondary"))
        }
        .background(Color("Secondary"))
        .onAppear {
            // Load latest goals
            allGoalsViewModel.loadLatestGoals()
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
