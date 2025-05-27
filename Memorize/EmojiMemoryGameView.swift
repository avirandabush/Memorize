//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Aviran Dabush on 13/05/2025.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            cards
                .animation(.bouncy, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    var cards: some View {
        AspectVGrid(for: viewModel.cards, aspectRatio: 2/3) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let cardBase = RoundedRectangle(cornerRadius: 12)
            
            Group {
                cardBase
                    .fill(Color(.white))
                cardBase
                    .strokeBorder(lineWidth: 3)
                    .foregroundColor(.cyan)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            cardBase
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        .foregroundStyle(Color(.cyan))
    }
}

// MARK: - Preview

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
