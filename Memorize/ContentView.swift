//
//  ContentView.swift
//  Memorize
//
//  Created by Aviran Dabush on 13/05/2025.
//

import SwiftUI

struct ContentView: View {
    let emojies = ["🕸️", "💀", "👻", "🎃", "😈", "👹", "👿", "🕷️", "🕸️", "💀", "👻", "🎃", "😈", "👹", "👿", "🕷️", "🎃", "😈", "👹", "👿", "🕷️"]
    @State var count: Int = 4

    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            countAdjustmentButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 120))]) {
            ForEach(0..<count, id: \.self) { emoji in
                CardView(content: emojies[emoji])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    var countAdjustmentButtons: some View {
        HStack {
            substructButton
            Spacer()
            addButton
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var substructButton: some View {
        countAdjustmentButton(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var addButton: some View {
        countAdjustmentButton(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    func countAdjustmentButton(by offset: Int, symbol: String) -> some View {
        Button(action: {
                count += offset
        }) {
            Image(systemName: symbol)
        }
        .disabled(count + offset < 2 || count + offset > emojies.count)
    }
}

struct CardView: View {
    @State var isFaceUp = false
    let content: String
    
    var body: some View {
        ZStack {
            let cardBase = RoundedRectangle(cornerRadius: 12)
            
            Group {
                cardBase
                    .fill(Color(.white))
                cardBase
                    .strokeBorder(lineWidth: 3)
                    .foregroundColor(.cyan)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            cardBase
                .opacity(isFaceUp ? 0 : 1)
        }
        .foregroundStyle(Color(.cyan))
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
