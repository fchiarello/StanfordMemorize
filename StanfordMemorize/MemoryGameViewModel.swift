//
//  MemoryGameViewModel.swift
//  StanfordMemorize
//
//  Created by Fellipe Ricciardi Chiarello on 5/19/23.
//

import SwiftUI

class MemoryGameViewModel: ObservableObject {
    typealias Card = MemoryGameModel<String>.Card
    
    private static let emojis = ["🚌", "🚛", "🛵", "🚀", "🛟", "🚔", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚜", "🦯", "🦽", "🦼", "🩼", "🛴", "🚲", "🛺", "🏍️", "🛞", "🚨"]
    
    private static func createMemoryGame() -> MemoryGameModel<String> {
        MemoryGameModel(numbersOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
