//
//  EmojiArtDocumentView.swift
//  course_2
//
//  Created by Naryu on 2021/05/08.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    @State private var chosenPalette: String = ""
    
    init (document: EmojiArtDocument) {
        self.document = document
        self._chosenPalette = State(wrappedValue: self.document.defaultPalette)
    }
    
    var body: some View {
        VStack {
            HStack {
                PaletteChooser(chosenPalette: $chosenPalette, document: document)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach (chosenPalette.map { String($0)}, id: \.self) { emoji in
                            Text(emoji)
                                .font(Font.system(size: self.defaultEmojiSize))
                                .onDrag { return NSItemProvider(object: emoji as NSString) }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            GeometryReader { geometry in
                ZStack {
                    Rectangle().foregroundColor(.white)
                        // ZStack을 사용하지 않은 이유는 .overlay를 하면 사이즈가 Rectangle()에 종속되기 때문이다.
                        .overlay(
                            optionalImage(uiImage: self.document.backgoundImage)
                                .scaleEffect(self.zoomScale)
                        )
                        .gesture(self.doubleTapToZoom(in: geometry.size))
                    if self.isLoading {
                        Image(systemName: "timer").imageScale(.large).spinning()
                    } else {
                        ForEach (self.document.emojis) { emoji in
                            Text(emoji.text)
                                .font(animatableWithSize: emoji.fontSize * zoomScale)
                                .position(self.position(for: emoji, in: geometry.size))
                        }
                    }
                }
                .clipped()
                .gesture(self.zoomGesture())
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .onReceive(self.document.$backgoundImage) { image in
                    self.zoomToFit(image, in: geometry.size)
                }
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                    var location = geometry.convert(location, from: .global)
                    location = CGPoint(x: location.x - geometry.size.width/2, y: location.y - geometry.size.height/2)
                    location = CGPoint(x: location.x / self.zoomScale, y: location.y / self.zoomScale)
                    return self.drop(providers: providers, at: location)
                }
                .navigationBarItems(trailing: Button(action: {
                    if let url = UIPasteboard.general.url {
                        self.document.backgroundURL = url
                    }
                }, label: {Image(systemName: "doc.on.clipboard").imageScale(.large)}))
            }
        }
        
    }
    
    var isLoading: Bool {
        document.backgroundURL != nil && document.backgoundImage == nil
    }
    
    @State private var steadyStateZoomScale: CGFloat = 1.0
    @GestureState private var gestureZoomScale: CGFloat = 1.0
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale*gestureZoomScale
    }
    
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, transaction in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { finalGestureScale in
                self.steadyStateZoomScale *= finalGestureScale
            }
    }
    
    private func doubleTapToZoom (in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    self.zoomToFit(document.backgoundImage, in: size)
                }
            }
    }
    
    private func zoomToFit (_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            self.steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
    private func position (for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        var location = emoji.location
        location = CGPoint(x: location.x / self.zoomScale, y: location.y / self.zoomScale)
        return CGPoint(x: location.x + size.width/2, y: location.y + size.height/2)
    }
    
    private func drop (providers: [NSItemProvider], at location: CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            self.document.backgroundURL = url
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

