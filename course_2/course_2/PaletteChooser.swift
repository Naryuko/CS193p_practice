//
//  PaletteChooser.swift
//  course_2
//
//  Created by Naryu on 2021/05/09.
//

import SwiftUI

struct PaletteChooser: View {
    @Binding var chosenPalette: String
    @State private var showPaletteEditor = false
    
    @ObservedObject var document: EmojiArtDocument
    
    var body: some View {
        HStack {
            Stepper(onIncrement: {
                self.chosenPalette = self.document.palette(after: self.chosenPalette)
            }, onDecrement: {
                self.chosenPalette = self.document.palette(before: self.chosenPalette)
            }, label: { })
            Text(self.document.paletteNames[self.chosenPalette] ?? "")
            Image(systemName: "keyboard").imageScale(.large)
                .onTapGesture {
                    self.showPaletteEditor = true
                }
                .sheet(isPresented: $showPaletteEditor) {
                    PaletteEditor(chosenPalette: $chosenPalette, isShowing: $showPaletteEditor)
                        .environmentObject(self.document)
                        .frame(minWidth: 300,minHeight: 500)
                }
        }
        .fixedSize(horizontal: true, vertical: false)
        .onAppear{ self.chosenPalette = self.document.defaultPalette }
    }
}


struct PaletteEditor: View {
    @Binding var chosenPalette: String
    @EnvironmentObject var document: EmojiArtDocument
    @State private var paletteName: String = ""
    @State private var emojisToAdd: String = ""
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("Palette Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: { self.isShowing = false }, label: { Text("Done")}).padding()
                }
            }
            Divider()
            Form {
                Section {
                    TextField("Palette Name", text: $paletteName) { began in
                        if !began {
                            self.document.renamePalette(self.chosenPalette, to: self.paletteName)
                        }
                    }
                        .padding()
                    TextField("Add Emoji", text: $emojisToAdd) { began in
                        if !began {
                            self.chosenPalette = self.document.addEmoji(self.emojisToAdd, toPalette: self.chosenPalette)
                            self.emojisToAdd = ""
                        }
                    }
                        .padding()
                }
                
                Section(header: Text("Remove Emoji")) {
                    Grid(items: chosenPalette.map { String($0)}, id: \.self) { emoji in
                        Text(emoji).font(Font.system(size: self.fontSize))
                            .onTapGesture {
                                self.chosenPalette = self.document.removeEmoji(emoji, fromPalette: self.chosenPalette)
                            }
                    }
                }
                .frame(height: self.height)
                
                
            }
            
            
        }
        .onAppear { self.paletteName = self.document.paletteNames[self.chosenPalette] ?? ""}
    }
    
    var height: CGFloat {
        CGFloat((chosenPalette.count - 1) / 6) * 70 + 70
    }
    let fontSize: CGFloat = 40
}
