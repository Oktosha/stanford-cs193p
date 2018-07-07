//
//  Concentration.swift
//  Concentration
//
//  Created by Daria Kolodzey on 7/6/18.
//  Copyright © 2018 Kolodzey Inc. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    var score = 0
    
    func chooseCard(at index: Int) {
        if cards[index].isMatched {
            return
        }
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex == index {
            return
        }
        flipCount += 1
        cards[index].timesSeen += 1
        if let matchIndex = indexOfOneAndOnlyFaceUpCard {
            if cards[matchIndex].identifier == cards[index].identifier {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
                score += 2
            } else {
                score -= cards[index].timesSeen > 1 ? 1 : 0
                score -= cards[matchIndex].timesSeen > 1 ? 1 : 0
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = nil
        } else {
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = false;
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = index
        }
    }
    
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        for index in 0..<cards.count {
            let randomShift = Int(arc4random_uniform(UInt32(cards.count - index)))
            cards.swapAt(index, index + randomShift)
        }

    }
}
