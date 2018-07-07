//
//  ViewController.swift
//  Concentration
//
//  Created by Daria Kolodzey on 7/6/18.
//  Copyright © 2018 Kolodzey Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    let themeEmoji = [["🐙", "🦀", "🐬", "🐟", "🐡", "🐠"],
                      ["👻", "🎃", "😱", "😼", "🙀", "😈"],
                      ["🌲", "🌳", "🍀", "🌴", "🌵", "🌷"],
                      ["🍗", "🍣", "🌮", "🥗", "🥞", "🥖"],
                      ["🏋️‍♀️", "🏊‍♀️", "🧗🏾‍♀️", "🧘🏻‍♀️", "🤾‍♂️", "🏄‍♂️"],
                      ["🎹", "🥁", "🎻", "🎸", "🎷", "🎤"]]
    
    @IBAction func newGame(_ sender: UIButton) {
        let randomThemeIndex = Int(arc4random_uniform(UInt32(themeEmoji.count)))
        emojiChoices = themeEmoji[randomThemeIndex]
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["👻", "🎃", "😱", "😼", "🙀", "😈"]
    var emoji = [Int:String]()
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

