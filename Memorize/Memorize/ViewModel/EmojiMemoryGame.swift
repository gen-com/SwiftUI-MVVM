//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/04/07.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    // MARK: Property(ies)
    
    static let emojis = ["🚂", "✈️", "🚀", "🚗", "🚌", "🚑", "🚜", "🚒", "🛺", "🚤", "🛳", "🛰"]
    
    @Published private var model = MemoryGame<String>(numberOfPairsOfCards: 4) { EmojiMemoryGame.emojis[$0] }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
