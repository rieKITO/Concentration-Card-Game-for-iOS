//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Alexander	 on 17.10.2023.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private var cardNumber = 24
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards, numberOfButtons: cardButtons.count)
    
    private (set) var flipCount: Int = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.401989106, green: 0.5202808558, blue: 0.7628291561, alpha: 1)
        ]
        let attributesString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributesString
    }
    
    private func updateScoreLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.401989106, green: 0.5202808558, blue: 0.7628291561, alpha: 1)
        ]
        let attributesString = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
        scoreLabel.attributedText = attributesString
    }
    
    var numberOfPairsOfCards: Int {
        return (cardNumber + 1) / 2
    }

    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private var menuButtons: [UIButton]!
    
    var theme: (String?, UIColor, UIColor, UIColor) = ("Default", .white, .white, .white) {
        didSet {
            emojiChoices = theme.0 ?? ""
            lastEmojiChoice = theme.0 ?? ""
            emoji = [:]
            faceUpCardBackgroundColor = theme.1
            faceDownCardBackgroundColor = theme.2
            mainBackgroundColor = theme.3
            updateViewFromModel()
        }
    }
    
    var difficulty: Int = 0 {
        didSet {
            cardNumber = difficulty
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "🦊🐻🦁🐙🐬🐼🐸🕷"
    private var lastEmojiChoice = "🦊🐻🦁🐙🐬🐼🐸🕷"
    private var faceUpCardBackgroundColor = #colorLiteral(red: 0.5038267664, green: 0.6173603365, blue: 0.7628291561, alpha: 1)
    private var faceDownCardBackgroundColor = #colorLiteral(red: 0.401989106, green: 0.5202808558, blue: 0.7628291561, alpha: 1)
    private var mainBackgroundColor = #colorLiteral(red: 0.4469177772, green: 0.7628291561, blue: 0.6397354423, alpha: 1)
    
    private var emoji = [Card: String]()
    
    @IBAction private func touchCard(_ sender: UIButton)
    {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        updateScoreLabel()
    }
    
    private func updateViewFromModel() {
        if cardButtons != nil, menuButtons != nil {
            for index in menuButtons.indices {
                menuButtons[index].backgroundColor = faceDownCardBackgroundColor
            }
            self.view.backgroundColor = mainBackgroundColor
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    
                    button.backgroundColor = faceUpCardBackgroundColor
                }
                else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.401989106, green: 0.5202808558, blue: 0.7628291561, alpha: 0) : faceDownCardBackgroundColor
                }
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards, numberOfButtons: cardButtons.count)
        emojiChoices = lastEmojiChoice
        flipCount = 0
        updateViewFromModel()
    }
    
    
    @IBAction func shuffleCards(_ sender: UIButton) {
        game.shuffle()
    }
    
    
    @IBAction func clue(_ sender: UIButton) {
        game.turnAllTheCards(faceUp: true)
        updateViewFromModel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.game.turnAllTheCards(faceUp: false)
            self.updateViewFromModel()
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
