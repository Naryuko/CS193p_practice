//
//  MemoryGame.swift
//  Course_1
//
//  Created by Naryu on 2021/04/27.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    typealias content = (Int) -> CardContent
    private(set) var cards: [Card]
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose (card: Card) {
        if let index = self.cards.firstIndex(matching: card), !cards[index].isFaceUp, !cards[index].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[index].content == cards[potentialMatchIndex].content {
                    cards[index].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
            }
            self.cards[index].isFaceUp = !self.cards[index].isFaceUp
        }
    }
    
    init (numberOfPairsOfCards: Int, cardContentFactory: content) {
        cards = []
        
        for i in 0..<numberOfPairsOfCards {
            cards.append(Card(id: 2*i, isFaceUp: false, isMatched: false, content: cardContentFactory(i)))
            cards.append(Card(id: 2*i+1, isFaceUp: false, isMatched: false, content: cardContentFactory(i)))
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
