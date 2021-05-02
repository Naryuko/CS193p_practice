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
        VStack {
            Grid(items: viewModel.cards) {card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 1)) {self.viewModel.choose(card: card)}
                }
                .padding(4)
            }
            
            Button(action: {withAnimation(.easeInOut) {self.viewModel.resetGame()}}, label: { Text("New Game")})
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
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    func body (for size: CGSize) -> some View {
        return Group {
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                                .onAppear {
                                    self.startBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                        }
                    }
                    .padding(5)
                    .opacity(0.4)
                    Text(card.content)
                        .font(Font.system(size: fontSize(for: size)))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        //animation only apply when only animated changes
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
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
