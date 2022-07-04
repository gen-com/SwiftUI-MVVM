//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/04/07.
//

import Combine
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
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
    
    var needFlipBackCards: AnyPublisher<[Card]?, Never> {
        $game
            .map({ game in
                game.cards.filter({ $0.isFaceUp }).count == 2 ? game.cards.filter({ $0.isFaceUp }) : nil
            })
            .eraseToAnyPublisher()
    }
    
    // MARK: - Initializer
    
    init(theme: Theme) {
        self.theme = theme
        game = EmojiMemoryGame.createMemoryGame(for: theme)
    }
    
    // MARK: - Intent(s)
    
    var filpBackCancellable: AnyCancellable?
    
    func choose(_ card: Card) {
        game.choose(card)
        
        filpBackCancellable?.cancel()
        filpBackCancellable = needFlipBackCards
            .delay(for: .seconds(Constants.flipBackDelaySecond), scheduler: DispatchQueue.main)
            .sink { [weak self] cards in
                if let cards = cards {
                    withAnimation {
                        self?.game.flipBack(cards)
                    }
                }
            }
    }
    
    func shuffle() {
        game.shuffle()
    }
    
    func restart() {
        theme = Theme()
        game = EmojiMemoryGame.createMemoryGame(for: theme)
    }
    
    // MARK: - Constant(s)
    
    private enum Constants {
        
        static let flipBackDelaySecond = 2
    }
}
