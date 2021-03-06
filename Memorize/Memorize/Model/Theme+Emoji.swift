//
//  Theme+Emoji.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/05/18.
//

import Foundation

extension Theme {
    
    enum Emoji {
        
        private static let halloweenEmojis = ["π", "π»", "π", "πΏ", "πΉ", "β οΈ", "πΎ", "π½"]
        private static let vehicleEmojis = ["π", "βοΈ", "π", "π", "π", "π", "π", "π", "πΊ", "π€", "π³", "π°"]
        private static let sportsEmojis = ["β½οΈ", "π", "π", "βΎοΈ", "π₯", "πΎ", "π", "π", "π₯", "π±", "πͺ", "π", "πΈ", "π", "π", "π₯"]
        private static let faceEmojis = ["π", "π₯Ή", "π", "π", "π", "π", "π€©", "π€¬", "π€―", "π«₯", "π«‘", "π₯±", "π€’", "π« ", "π«£", "πΆβπ«οΈ", "π", "π₯΅", "π₯³"]
        
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
