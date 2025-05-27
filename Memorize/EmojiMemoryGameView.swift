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
        GeometryReader { geometry in
            let aspectRatio: CGFloat = 2/3
            let gridItemSize = scaleForSize(count: CGFloat(viewModel.cards.count),
                                            size: geometry.size,
                                            aspectRatio: aspectRatio)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
    
    func scaleForSize(count: CGFloat, size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1.0
        
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = ceil(count / columnCount)
            
            if rowCount * height < size.height {
                return floor(size.width / columnCount)
            }
            columnCount += 1
        } while columnCount < count
        
        return floor(min(size.width / count, size.height * aspectRatio))
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

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
