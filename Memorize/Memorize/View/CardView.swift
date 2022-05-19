//
//  CardView.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/05/19.
//

import SwiftUI

struct CardView: View {
    
    // MARK: - Property(ies)
    
    let card: EmojiMemoryGame.Card
    
    @State
    private var animatedBonusRemaining = 0.0
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(
                            startAngle: Angle(degreesFromTwelve: 0),
                            endAngle: Angle(degreesFromTwelve: (1 - animatedBonusRemaining) * 360)
                        )
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(
                            startAngle: Angle(degreesFromTwelve: 0),
                            endAngle: Angle(degreesFromTwelve: (1 - card.bonusRemaining) * 360)
                        )
                    }
                }
                .padding(CardConstants.piePadding)
                .opacity(CardConstants.pieOpacity)
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(
                        .linear(duration: CardConstants.rotateDuration)
                        .repeatCount(CardConstants.rotateRepeatCount, autoreverses: false),
                        value: card.isMatched
                    )
                    .font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * CardConstants.fontScale)
    }
    
    // MARK: Constants
    
    private enum CardConstants {
        
        static let rotateDuration = 1.0
        static let rotateRepeatCount = 2
        
        static let piePadding: CGFloat = 5
        static let pieOpacity = 0.5
        
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EmojiMemoryGame(theme: Theme())
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portrait)
    }
}
