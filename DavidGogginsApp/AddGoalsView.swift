//
//  AddGoalsView.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-12.
//

import SwiftUI

struct AddGoalsView: View {
    
    @State var inputText = ""
    
    var body: some View {
        
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // Image
                Image(systemName: "bolt.fill")
                    .font(.system(size: 150))
                    .foregroundColor(.yellow)
                    .shadow(radius: 30)
                
                // Title
                Text("What is your goal?")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                TextField("", text: $inputText)
                    .frame(height: 60)
                    .font(.system(size: 23))
                    .foregroundColor(Color.white)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white))
                    .padding()
                
                // Buttons (for accepting and rejecting)
                HStack(spacing: 20) {
                    CircleButton(iconName: "xmark") {
                        //
                    }
                    
                    CircleButton(iconName: "checkmark") {
                        //
                    }
                }
                // Buttons
                
                
            }
        }
        
    }
}

#Preview {
    AddGoalsView()
}