//
//  Cardify.swift
//  Course_1
//
//  Created by Naryu on 2021/05/02.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body (content: Content) -> some View {
        return ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill().foregroundColor(.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke()
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }.foregroundColor(.orange)
    }
    
    private let cornerRadius: CGFloat = 10
}

extension View {
    func cardify (isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
