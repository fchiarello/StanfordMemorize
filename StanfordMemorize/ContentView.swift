//
//  ContentView.swift
//  StanfordMemorize
//
//  Created by Fellipe Ricciardi Chiarello on 5/9/23.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🚌", "🚛", "🛵", "🚀", "🛟", "🚔", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚜", "🦯", "🦽", "🦼", "🩼", "🛴", "🚲", "🛺", "🏍️", "🛞", "🚨"]
   
    @State var emojiCount = 25
    
    var body: some View {
        VStack {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], content: {
                  ForEach(emojis[..<emojiCount], id: \.self, content: { emoji in
                      CardView(content: emoji)
                          .aspectRatio(2/3, contentMode: .fit)
                  })
                })
            }

            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1

            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
