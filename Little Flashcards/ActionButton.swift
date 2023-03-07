//
//  ActionButton.swift
//  Little Flashcards
//
//  Created by Kilo Loco on 2/18/23.
//

import SwiftUI

struct ActionButton<Content: View>: View {
    let imageName: String
    let action: () -> Void
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            content()
            
            Button(action: action) {
                Image(systemName: imageName)
            }
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.accentColor)
            .clipShape(Circle())
            .padding()
            
        }
        
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(imageName: "plus", action: {}, content: {
            List {
                Text("hello world")
            }
        })
    }
}
