//
//  Theme+Name.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/05/17.
//

import Foundation

extension Theme {
    
    enum Name: String {
        
        case vehicles
        case sports
        case faces
        case halloweens
        
        static let all = [Name.vehicles, .sports, .faces, .halloweens]
    }
}
