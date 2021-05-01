//
//  MemoryGame.swift
//  Course_1
//
//  Created by Naryu on 2021/04/27.
//

import Foundation

struct MemoryGame<CardContent> {
    typealias content = (Int) -> CardContent
    var cards: [Card]
    
    mutating func choose (card: Card) {
        print("Card is chosen: \(card)")
         self.cards[index(of: card)].isFaceUp = !self.cards[index(of: card)].isFaceUp
    }
    
    func index (of card: Card) -> Int {
        for i in 0..<self.cards.count {
            if self.cards[i].id == card.id {
                return i
            }
        }
        return 0
    }
    
    init (numberOfPairsOfCards: Int, cardContentFactory: content) {
        cards = []
        
        for i in 0..<numberOfPairsOfCards {
            cards.append(Card(id: 2*i, isFaceUp: true, isMatched: false, content: cardContentFactory(i)))
            cards.append(Card(id: 2*i+1, isFaceUp: true, isMatched: false, content: cardContentFactory(i)))
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
