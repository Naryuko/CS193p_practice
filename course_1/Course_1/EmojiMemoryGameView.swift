//
//  EmojiMemoryGameView.swift
//  Course_1
//
//  Created by Naryu on 2021/04/27.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // ObservedObject는 해당 property가 ObservedObject를 상속한 것을 알려줌
    @ObservedObject var viewModel: EmojiMemoryGame
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
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            body(for: geometry.size)
        })
    }
    
    func body (for size: CGSize) -> some View {
        return ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill().foregroundColor(.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke()
                Text(card.content).font(Font.system(size: fontSize(for: size)))
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }.foregroundColor(.orange)
    }
    
    // MARK: -Drawing Constants
    
    let cornerRadius: CGFloat = 10
    let fontScaleFactor: CGFloat = 0.75
    func fontSize (for size: CGSize) -> CGFloat {
        return min(size.width, size.height)*fontScaleFactor
    }
}
