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
        Grid(items: viewModel.cards) {card in
            CardView(card: card).onTapGesture {
                self.viewModel.choose(card: card)
            
            }
            .padding()
        }
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
        return Group {
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20), clockwise: true).padding(5).opacity(0.4)
                    Text(card.content).font(Font.system(size: fontSize(for: size)))
                }
                .cardify(isFaceUp: card.isFaceUp)
            }
        }
    }
    
    // MARK: -Drawing Constants
    
    private let fontScaleFactor: CGFloat = 0.65
    private func fontSize (for size: CGSize) -> CGFloat {
        return min(size.width, size.height)*fontScaleFactor
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[3])
        return EmojiMemoryGameView(viewModel: game)
    }
}
