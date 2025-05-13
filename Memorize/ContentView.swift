//
//  ContentView.swift
//  Memorize
//
//  Created by Aviran Dabush on 13/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
            CardView(isFaceUp: true)
            CardView()
        }
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color(.white))
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                    .foregroundColor(.cyan)
                Text("😳")
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
        .foregroundStyle(Color(.cyan))
    }
}

#Preview {
    ContentView()
}
