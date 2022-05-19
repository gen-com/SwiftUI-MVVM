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
    
    private(set) var matchingCards: [Card] = []
    
    // MARK: Static Method(s)
    
    private static func createMemoryGame(for theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { theme.emojis[$0] }
    }
    
    // MARK: - Model
    
    @Published
    private var game: MemoryGame<String>
    @Published
    private var theme: Theme
    
    var cards: [Card] {
        game.cards
    }
    var themeNameString: String {
        theme.name.rawValue
    }
    var themeColor: Theme.Color {
        theme.color
    }
    
    // MARK: - Initializer
    
    init(theme: Theme) {
        self.theme = theme
        game = EmojiMemoryGame.createMemoryGame(for: theme)
    }
    
    // MARK: - Intent(s)
    
    /// Added a little trick to make sure matchingCards don't exceed 2 elements.
    func choose(_ card: Card) {
        game.choose(card)
        matchingCards.append(card)
        if 2 < matchingCards.count {
            matchingCards.removeAll()
            matchingCards.append(card)
        }
    }
    
    func flipBack() {
        game.flipBack(matchingCards)
        matchingCards.removeAll()
    }
    
    func shuffle() {
        game.shuffle()
    }
    
    func restart() {
        theme = Theme()
        game = EmojiMemoryGame.createMemoryGame(for: theme)
    }
}
