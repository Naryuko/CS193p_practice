//
//  PaletteChooser.swift
//  course_2
//
//  Created by Naryu on 2021/05/09.
//

import SwiftUI

struct PaletteChooser: View {
    @Binding var chosenPalette: String
    
    @ObservedObject var document: EmojiArtDocument
    
    var body: some View {
        HStack {
            Stepper(onIncrement: {
                self.chosenPalette = self.document.palette(after: self.chosenPalette)
            }, onDecrement: {
                self.chosenPalette = self.document.palette(before: self.chosenPalette)
            }, label: { })
            Text(self.document.paletteNames[self.chosenPalette] ?? "")
        }
        .fixedSize(horizontal: true, vertical: false)
        .onAppear{ self.chosenPalette = self.document.defaultPalette }
    }
}
