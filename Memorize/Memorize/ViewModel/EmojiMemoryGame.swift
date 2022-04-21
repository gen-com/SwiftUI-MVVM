//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/04/07.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    // MARK: Property(ies)
    
    private static let emojis = ["🚂", "✈️", "🚀", "🚗", "🚌", "🚑", "🚜", "🚒", "🛺", "🚤", "🛳", "🛰"]
    
    @Published
    private var model = MemoryGame<String>(numberOfPairsOfCards: 8) { EmojiMemoryGame.emojis[$0] }
    
    var cards: [Card] {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
