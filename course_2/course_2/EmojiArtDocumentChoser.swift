//
//  EmojiArtDocumentChoser.swift
//  course_2
//
//  Created by Naryu on 2021/05/16.
//

import SwiftUI

struct EmojiArtDocumentChoser: View {
    @EnvironmentObject var store: EmojiArtDocumentStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.documents) { document in
                    NavigationLink(destination: EmojiArtDocumentView(document: document)
                                    .navigationBarTitle(self.store.name(for: document))) {
                        Text(self.store.name(for: document))
                    }
                }
            }
            .navigationBarTitle(self.store.name)
            .navigationBarItems(leading: Button(action: {self.store.addDocument()}, label: { Image(systemName: "plus").imageScale(.large)}))
        }
    }
    
    
}
