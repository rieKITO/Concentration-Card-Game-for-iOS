//
//  Concentration.swift
//  Concentration
//
//  Created by Alexander	 on 10.12.2023.
//

import Foundation

struct Concentration {
    
    private (set) var cards = [Card]()
    var numberOfCards: Int
    private var clueNumber = 10
    var score: Int = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): choosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else if score > 0 {
                    score -= 1
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, numberOfButtons: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): to must at least one pair of cards")
        numberOfCards = numberOfPairsOfCards * 2
        for _ in 1...(numberOfButtons+1)/2 {
            let card = Card()
            cards += [card, card]
        }
        for index in numberOfCards..<numberOfButtons{
            cards[index].isMatched = true
        }
        shuffle()
    }
    
    mutating func shuffle() {
        for index in 0..<numberOfCards {
            let randomIndex = Int(arc4random_uniform(UInt32(numberOfCards - index))) + index
            cards.swapAt(index, randomIndex)
        }
    }
    
    mutating func turnAllTheCards(faceUp: Bool) {
        if !faceUp || clueNumber > 0 {
            if faceUp {
                clueNumber -= 1
            }
            for index in 0..<numberOfCards {
                if !cards[index].isMatched {
                    if faceUp {
                        cards[index].isFaceUp = true
                    } else {
                        cards[index].isFaceUp = false
                    }
                }
            }
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
