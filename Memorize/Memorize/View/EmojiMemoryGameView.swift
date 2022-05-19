//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/04/05.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    // MARK: - ViewModel
    
    @ObservedObject
    var game: EmojiMemoryGame
    
    @State
    private var dealt = Set<Int>()
    
    @Namespace
    private var dealingNamespace
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                VStack {
                    title
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height * MemoryGameConstants.titleHeightRatio,
                            alignment: .center
                        )
                    gameBody
                    HStack {
                        restart
                        Spacer()
                        shuffle
                    }
                }
            }
            deckBody
        }
        .foregroundColor(MemoryGameConstants.color(game.themeColor))
        .padding()
    }
    
    // MARK: - View(s)
    
    var title: some View {
        GeometryReader { geometry in
            Text("\(MemoryGameConstants.title) \(game.themeNameString)!")
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .font(Font.system(size: min(geometry.size.width, geometry.size.height) * MemoryGameConstants.titleFontRatio))
        }
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: MemoryGameConstants.cardAspectRatio) { card in
            if isUndealt(card) || (card.isMatched && card.isFaceUp == false) {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(MemoryGameConstants.cardViewPadding)
                    .transition(.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                            if game.matchingCards.count == MemoryGameConstants.maxinumMatching {
                                DispatchQueue.main.asyncAfter(
                                    deadline: .now() + .seconds(MemoryGameConstants.flipBackDelay),
                                    qos: .userInteractive
                                ) {
                                    if game.matchingCards.count == MemoryGameConstants.maxinumMatching {
                                        withAnimation() {
                                            game.flipBack()
                                        }
                                    }
                                }
                            }
                        }
                    }
            }
        }
        .foregroundColor(MemoryGameConstants.color(game.themeColor))
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: MemoryGameConstants.undealtWidth, height: MemoryGameConstants.undealtHeight)
        .foregroundColor(MemoryGameConstants.color(game.themeColor))
        .onTapGesture {
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var restart: some View {
        Button(MemoryGameConstants.restartButtonTitle) {
            withAnimation {
                dealt = []
                game.restart()
            }
        }
        .foregroundColor(MemoryGameConstants.color(game.themeColor))
    }
    
    var shuffle: some View {
        Button(MemoryGameConstants.shuffleButtonTitle) {
            withAnimation {
                game.shuffle()
            }
        }
        .foregroundColor(MemoryGameConstants.color(game.themeColor))
    }
    
    // MARK: - Method(s)
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (MemoryGameConstants.totalDealDuration / Double(game.cards.count))
        }
        
        return Animation.easeInOut(duration: MemoryGameConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    // MARK: - Constants
    
    private enum MemoryGameConstants {
        
        static let title = "Memorize"
        static let titleHeightRatio = 0.1
        static let titleFontRatio = 0.5
        
        static let cardAspectRatio: CGFloat = 2 / 3
        static let cardViewPadding: CGFloat = 4
        
        static let flipBackDelay = 1
        static let maxinumMatching = 2
        
        static let dealDuration = 0.5
        static let totalDealDuration = 2.0
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * cardAspectRatio
        
        static let restartButtonTitle = "Restart"
        static let shuffleButtonTitle = "Shuffle"
        
        static func color(_ color: Theme.Color) -> Color {
            switch color {
            case .red:
                
                return .red
            case .orange:
                
                return .orange
            case .blue:
                
                return .blue
            case .black:
                
                return .black
            }
        }
    }
}
