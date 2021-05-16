//
//  Grid.swift
//  Course_1
//
//  Created by Naryu on 2021/05/02.
//

import SwiftUI

//extension Grid where Item: Identifiable, Item.id == ID {
//    init (_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
//        self.init(items: items, id: \Item.id, viewForItem: viewForItem)
//    }
//}

struct Grid<Item, ID, ItemView>: View where ID: Hashable, ItemView: View {
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    private var id: KeyPath<Item, ID>
        
    init (items: [Item], id: KeyPath<Item, ID>, viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
        self.id = id
    }

    var body: some View {
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    func body (for layout: GridLayout) -> some View {
        ForEach(items, id: id) { item in
            body(for: item, in: layout)
        }
    }
    
    func body (for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(where: { item[keyPath: id] == $0[keyPath: id] })
        return Group {
            if index != nil {
                viewForItem(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: index!))
            }
        }
    }
        
    
    
}