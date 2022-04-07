//
//  ContentView.swift
//  Memorize
//
//  Created by Byeongjo Koo on 2022/04/05.
//

import SwiftUI

struct ContentView: View {
    
    var emojis = ["🚂", "✈️", "🚀", "🚗", "🚌", "🚑", "🚜", "🚒", "🛺", "🚤", "🛳", "🛰"]
    @State var emojiCount = 12
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0 ..< emojiCount], id: \.self) {
                        CardView(content: $0).aspectRatio(2 / 3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
        }
        
        .padding()
    }
    
    var remove: some View {
        Button(
            action: {
                if 1 < emojiCount {
                    emojiCount -= 1
                }
            },
            label: { Image(systemName: "minus.circle") }
        )
    }
    var add: some View {
        Button(
            action: {
                if emojiCount < emojis.count {
                    emojiCount += 1
                }
            },
            label: { Image(systemName: "plus.circle") }
        )
    }
}

struct CardView: View {
    
    @State var isFaceUp = true
    var content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portrait)
    }
}
