//
//  course_2App.swift
//  course_2
//
//  Created by Naryu on 2021/05/08.
//

import SwiftUI

@main
struct course_2App: App {
    
    var body: some Scene {
        let store = EmojiArtDocumentStore(named: "Emoji Art")
        
        WindowGroup {
            EmojiArtDocumentChoser().environmentObject(store)
        }
    }
}
