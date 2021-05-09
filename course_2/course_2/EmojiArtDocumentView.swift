//
//  EmojiArtDocumentView.swift
//  course_2
//
//  Created by Naryu on 2021/05/08.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach (EmojiArtDocument.palette.map { String($0)}, id: \.self) { emoji in
                    Text(emoji)
                        .font(Font.system(size: self.defaultEmojiSize))
                        .onDrag { return NSItemProvider(object: emoji as NSString) }
                }
            }

        }
        .padding(.horizontal)
        GeometryReader { geometry in
            ZStack {
                Rectangle().foregroundColor(.white)
                    .overlay(
                        Group {
                            if self.document.backgoundImage != nil {
                                Image(uiImage: self.document.backgoundImage!)
                            }
                        }
                    )
                    // ZStack을 사용하지 않은 이유는 .overlay를 하면 사이즈가 Rectangle()에 종속되기 때문이다.
                    .edgesIgnoringSafeArea([.horizontal, .bottom])
                    .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                        var location = geometry.convert(location, from: .global)
                        location = CGPoint(x: location.x - geometry.size.width/2, y: location.y - geometry.size.height/2)
                        return self.drop(providers: providers, at: location)
                    }
                ForEach (self.document.emojis) { emoji in
                    Text(emoji.text)
                        .font(self.font(for: emoji))
                        .position(self.position(for: emoji, in: geometry.size))
                }
            }
        }
        
    }
    
    private func font (for emoji: EmojiArt.Emoji) -> Font {
        return Font.system(size: emoji.fontSize)
    }
    
    private func position (for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        CGPoint(x: emoji.location.x + size.width/2, y: emoji.location.y + size.height/2)
    }
    
    private func drop (providers: [NSItemProvider], at location: CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            self.document.setBackgroundURL(url: url)
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                self.document.addEmoji(emoji: string, at: location, size: self.defaultEmojiSize)
            }
        }
        
        return found
    }
    
    
    // MARK: - Design Factor
    private let defaultEmojiSize: CGFloat = 40
}
