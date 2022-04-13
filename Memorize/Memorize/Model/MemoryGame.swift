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
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    // MARK: - Initializer
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> (CardContent)) {
        cards = []
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let card = Card(id: pairIndex * 2, content: createCardContent(pairIndex))
            let pairCard = Card(id: pairIndex * 2 + 1, content: createCardContent(pairIndex))
            cards += [card, pairCard]
        }
    }
    
    // MARK: - Function(s)
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           cards[chosenIndex].isFaceUp == false,
           cards[chosenIndex].isMatched == false {
            if let potentialFaceUpCardIndex = indexOfOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialFaceUpCardIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialFaceUpCardIndex].isMatched = true
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
}

// MARK: - Card

extension MemoryGame {
    
    struct Card: Identifiable {
        
        var id: Int
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
}
