//
//  Cardify.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/04/28.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    // MARK: - Property(ies)
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    var rotation: Double
    
    // MARK: - Initializer
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    // MARK: - Method(s)
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    // MARK: - Constants
    
    private enum DrawingConstants {
        
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

// MARK: - View Extension

extension View {
    
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
