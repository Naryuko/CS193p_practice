//
//  EmojiMemoryGame.swift
//  Course_1
//
//  Created by Naryu on 2021/04/27.
//

import SwiftUI

class EmojiMemoryGame {
    private var model: MemoryGame<String> = createMemoryGame()
        
    static func createMemoryGame () -> MemoryGame<String> {
        let emojiArr = ["🐶","🐱","🐰"]
        return MemoryGame<String>(numberOfPairsOfCards: 3) { (index) in return emojiArr[index%3] }
    }
    
    // MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose (card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
