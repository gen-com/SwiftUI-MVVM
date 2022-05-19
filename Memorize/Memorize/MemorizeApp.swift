//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/04/05.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    private let game = EmojiMemoryGame(theme: Theme())
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
