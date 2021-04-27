//
//  ContentView.swift
//  Course_1
//
//  Created by Naryu on 2021/04/27.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 40).fill().foregroundColor(.white)
                RoundedRectangle.init(cornerRadius: 40).stroke()
                Text(card.content).font(Font.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 40).fill()
            }
        }.foregroundColor(.orange)
    }
}
