//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Aviran Dabush on 14/05/2025.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojies = ["🕸️", "💀", "👻", "🎃", "😈", "👹", "👿", "🕷️", "🧟‍♂️", "🧛‍♀️", "🦇", "🍬", "🍭", "🍫", "🍪"]
    
    @Published private var gameViewModel = MemoryGame(numberOfCardsPairs: emojies.count) { pairIndex in
        if emojies.indices.contains(pairIndex) {
            emojies[pairIndex]
        } else {
            "❓"
        }
    }
    
    var cards: [MemoryGame<String>.Card] {
        return gameViewModel.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        self.gameViewModel.choose(card)
    }
    
    func shuffle() {
        self.gameViewModel.shuffle()
    }
}
