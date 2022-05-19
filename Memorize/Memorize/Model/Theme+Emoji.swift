//
//  Theme+Emoji.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/05/18.
//

import Foundation

extension Theme {
    
    enum Emoji {
        
        private static let halloweenEmojis = ["🎃", "👻", "💀", "👿", "👹", "☠️", "👾", "👽"]
        private static let vehicleEmojis = ["🚂", "✈️", "🚀", "🚗", "🚌", "🚑", "🚜", "🚒", "🛺", "🚤", "🛳", "🛰"]
        private static let sportsEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍"]
        private static let faceEmojis = ["😀", "🥹", "😂", "😇", "😙", "😎", "🤩", "🤬", "🤯", "🫥", "🫡", "🥱", "🤢", "🫠", "🫣", "😶‍🌫️", "😖", "🥵", "🥳"]
        
        static func emoji(for themeName: Theme.Name) -> [String] {
            let emoji: [String]
            switch themeName {
            case .vehicles:
                emoji = Emoji.vehicleEmojis
            case .sports:
                emoji = Emoji.sportsEmojis
            case .faces:
                emoji = Emoji.faceEmojis
            case .halloweens:
                emoji = Emoji.halloweenEmojis
            }
            
            return emoji.shuffled()
        }
    }
}
