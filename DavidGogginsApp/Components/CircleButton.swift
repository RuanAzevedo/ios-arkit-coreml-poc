//
//  CircleButton.swift
//  DavidGogginsApp
//
//  Created by Ruan Azevedo on 2024-03-12.
//

import SwiftUI

struct CircleButton: View {
    
    var iconName :String
    var action: () -> Void
    
    var body: some View {
        Button {
            // Do Something
            action()
            
        } label: {
            Image(systemName: iconName)
                .frame(width: 75, height: 75, alignment: .center)
                .background(.yellow)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    CircleButton(iconName: "plus",  action: {})
}
