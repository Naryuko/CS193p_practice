//
//  EmojiArt.swift
//  course_2
//
//  Created by Naryu on 2021/05/09.
//

import Foundation

struct EmojiArt: Codable {
    var backgroundURL: URL?
    var emojis: [Emoji] = []
    
    struct Emoji: Identifiable, Codable {
        let text: String
        var x: Int
        var y: Int
        var size: Int
        var id: Int
        
        fileprivate init (text: String, x: Int, y: Int, size: Int, id: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    private var uniqueEmojiId = 0
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init? (json: Data?) {
        if json != nil, let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!) {
            self = newEmojiArt
        } else {
            return nil
        }
    }
    
    init () { }
    
    mutating func addEmoji (_ text: String, x: Int, y: Int, size: Int) {
        emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniqueEmojiId))
        uniqueEmojiId += 1
    }
    
}
