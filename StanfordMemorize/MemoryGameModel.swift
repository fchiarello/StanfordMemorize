//
//  MemoryGameModel.swift
//  StanfordMemorize
//
//  Created by Fellipe Ricciardi Chiarello on 5/19/23.
//

import Foundation

enum MemorizeThemes {
    case vehicles
    case halloween
    case food
}

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    private (set) var cards: Array<Card>
    
    private var facedUpCardUniqueIndex: Int? {
        get {
            cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly
        }
        set {
            cards.indices.forEach{ cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let facedUpIndex = facedUpCardUniqueIndex {
                if cards[chosenIndex].content == cards[facedUpIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[facedUpIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                facedUpCardUniqueIndex = chosenIndex
            }
        }
    }
    
    init(numbersOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numbersOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2+1, content: content))
        }
    }
    
    struct Card: Identifiable {
        let id: Int
        var isFaceUp = false
        var isMatched = false
        var didSeenIt = false
        let content: CardContent
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
