//
//  AllGoalsView.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-12.
//

import SwiftUI

struct AllGoalsView: View {
    
    var allGoals: [String] = [
        "10 pomodoros a day",
        "Workout",
        "Wake up at 5:00 AM",
        "Create youtube content",
        "Eat healthy"
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
           // Text
            Text("Your Goals")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .padding(.leading)
            
            // List View
            List {
                ForEach(allGoals, id: \.self) { goal in
                    // Goal View
                    ListRow(text: goal)
                }
                .onDelete(perform: { indexSet in
                    // Delete logic
                })
            }
            .scrollContentBackground(.hidden)
            .background(.blue)
        }
        .background(.blue)
    }
}

struct ListRow: View {
    let text: String
    
    var body: some View {
        Text(text)
            .listRowBackground(Color.yellow)
            .foregroundColor(.black)
            .font(.body.bold())
    }
}

#Preview {
    AllGoalsView()
}
