//
//  Theme.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/05/17.
//

import Foundation

struct Theme {
    
    // MARK: - Properties
    
    private(set) var name: Name
    var numberOfPairsOfCards: Int {
        let number = 8
        
        return emojis.count < number ? emojis.count : number
    }
    var color: Color {
        Color.color(for: name)
    }
    private(set) var emojis: [String]
    
    // MARK: - Initializer
    
    /// Randomly generate theme.
    init() {
        name = Name.all.randomElement() ?? .vehicles
        emojis = Emoji.emoji(for: name)
    }
}
