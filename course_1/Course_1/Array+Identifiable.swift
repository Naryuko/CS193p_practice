//
//  Array+Identifiable.swift
//  Course_1
//
//  Created by Naryu on 2021/05/02.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex (matching: Element) -> Int? {
        for i in 0..<self.count {
            if self[i].id == matching.id {
                return i
            }
        }
        return nil // TODO: bogus!
    }
}
