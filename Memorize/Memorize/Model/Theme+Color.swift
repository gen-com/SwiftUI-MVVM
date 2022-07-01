//
//  Theme+Color.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/05/17.
//

import Foundation

extension Theme {
    
    enum Color {
        
        case red
        case orange
        case blue
        case purple
        
        static func color(for themeName: Theme.Name) -> Color {
            let color: Color
            switch themeName {
            case .vehicles:
                color = .red
            case .sports:
                color = .blue
            case .faces:
                color = .purple
            case .halloweens:
                color = .orange
            }
            
            return color
        }
    }
}
