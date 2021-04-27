//
//  Course_1App.swift
//  Course_1
//
//  Created by Naryu on 2021/04/27.
//

import SwiftUI

@main
struct Course_1App: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            ContentView(viewModel: game)
        }
    }
}
