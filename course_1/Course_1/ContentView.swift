//
//  ContentView.swift
//  Course_1
//
//  Created by Naryu on 2021/04/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                CardView(isFaceUp: true)
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var isFaceUp: Bool
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 40).fill().foregroundColor(.white)
                RoundedRectangle.init(cornerRadius: 40).stroke()
                Text("👻").font(Font.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 40).fill()
            }
        }.foregroundColor(.orange)
    }
}
