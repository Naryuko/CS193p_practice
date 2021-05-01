//
//  Array+Only.swift
//  Course_1
//
//  Created by Naryu on 2021/05/02.
//

import Foundation

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
