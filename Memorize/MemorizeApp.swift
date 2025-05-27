//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Aviran Dabush on 13/05/2025.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @State var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
