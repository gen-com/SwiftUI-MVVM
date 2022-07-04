//
//  MemoryGame.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/04/07.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    // MARK: - Property(ies)
    
    private(set) var cards: [Card]
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    // MARK: - Initializer(s)
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> (CardContent)) {
        cards = []
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let card = Card(id: pairIndex * 2, content: createCardContent(pairIndex))
            let pairCard = Card(id: pairIndex * 2 + 1, content: createCardContent(pairIndex))
            cards += [card, pairCard]
        }
        cards.shuffle()
    }
    
    // MARK: - Method(s)
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           cards[chosenIndex].isFaceUp == false,
           cards[chosenIndex].isMatched == false {
            if let potentialFaceUpCardIndex = indexOfOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialFaceUpCardIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialFaceUpCardIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    /// Flip cards back, if it is face up.
    mutating func flipBack(_ targetCards: [Card]) {
        for card in targetCards {
            if let targetIndex = cards.firstIndex(where: { $0.id == card.id }), cards[targetIndex].isFaceUp {
                cards[targetIndex].isFaceUp = false
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
}

// MARK: - Card

extension MemoryGame {
    
    struct Card: Identifiable {
        
        let id: Int
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        /// It can be zero which means "no bonus available" for this card.
        var bonusTimeLimit: TimeInterval = 6
        
        /// How long this card has ever been face up.
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                
                return pastFaceUpTime
            }
        }
        /// The last time this card was turned face up (and is still face up).
        var lastFaceUpDate: Date?
        /// The accumulated time this card has been face up in the past
        /// (i.e. not including the current time it's been face up if it is currently so).
        var pastFaceUpTime: TimeInterval = 0
        
        /// How much time left before the bonus opportunity runs out.
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        /// Percentage of the bonus time remaining.
        var bonusRemaining: Double {
            (0 < bonusTimeLimit && 0 < bonusTimeRemaining) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        /// Whether the card was matched during the bonus time period.
        var hasEarnedBonus: Bool {
            isMatched && 0 < bonusTimeRemaining
        }
        /// Whether we are currently face up, unmatched and have not yet used up the bonus window.
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && 0 < bonusTimeRemaining
        }
        
        /// This called when the card transitions to face up state.
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        /// This called when the card goes back face down (or gets matched).
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
