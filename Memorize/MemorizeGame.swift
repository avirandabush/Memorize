//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Aviran Dabush on 14/05/2025.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    init(numberOfCardsPairs: Int, cardContentFactory: (Int) -> CardContent) {
        self.cards = []
        
        for pairIndex in 0..<max(2, numberOfCardsPairs) {
            let content = cardContentFactory(pairIndex)
            cards.append(.init(id: "\(pairIndex+1)a", content: content))
            cards.append(.init(id: "\(pairIndex+1)b", content: content))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let index = cards.firstIndex(of: card) {
            if !cards[index].isFaceUp && !cards[index].isMatched {
                if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                    if cards[potentialMatchIndex].content == cards[index].content {
                        cards[potentialMatchIndex].isMatched = true
                        cards[index].isMatched = true
                    }
                } else {
                    indexOfOneAndOnlyFaceUpCard = index
                }
                cards[index].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        var id: String
        
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
