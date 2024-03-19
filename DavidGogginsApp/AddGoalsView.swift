//
//  AddGoalsView.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-12.
//

import SwiftUI

struct AddGoalsView: View {
    
    @State var inputText = ""
    
    @Binding var isViewShowing: Bool
    
    var body: some View {
        
        ZStack {
            Color("Secondary").ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // Image
                Image(systemName: "bolt.fill")
                    .font(.system(size: 150))
                    .foregroundColor(Color("Primary"))
                    .shadow(radius: 30)
                
                // Title
                Text("What is your goal?")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color("Accent"))
                
                TextField("", text: $inputText)
                    .frame(height: 60)
                    .font(.system(size: 23))
                    .foregroundColor(Color.white)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color("Primary")))
                    .padding()
                
                // Buttons (for accepting and rejecting)
                HStack(spacing: 20) {
                    CircleButton(iconName: "xmark") {
                        // Dismiss
                        isViewShowing = false
                    }
                    
                    CircleButton(iconName: "checkmark") {
                        // CRUD: Create a new goal
                        if(inputText != ""){
                            PersistenceManager.shared.createGoal(text: inputText)
                        }
                        
                        // Dismiss
                        isViewShowing = false
                        
                    }
                }
                // Buttons
                
                
            }
        }
        
    }
}

#Preview {
    AddGoalsView( isViewShowing: .constant(true))
}
