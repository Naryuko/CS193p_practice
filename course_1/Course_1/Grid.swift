//
//  Grid.swift
//  Course_1
//
//  Created by Naryu on 2021/05/02.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
        
    init (items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }

    var body: some View {
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    func body (for layout: GridLayout) -> some View {
        ForEach(items) { item in
            body(for: item, in: layout)
        }
    }
    
    func body (for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)
        return Group {
            if index != nil {
                viewForItem(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: index!))
            }
        }
    }
        
    
    
}
