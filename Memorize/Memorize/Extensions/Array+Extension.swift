//
//  Int+Extension.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/04/21.
//

import Foundation

extension Array {
    
    var oneAndOnly: Element? {
        self.count == 1 ? self.first : nil
    }
}
