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
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.cards, id: \.id) { card in
                    CardView(card: card)
                        .aspectRatio(2 / 3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .font(.largeTitle)
        .padding()
    }
}

struct CardView: View {
    
    // MARK: - Property(ies)
    
    let card: EmojiMemoryGame.Card
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portrait)
    }
}
