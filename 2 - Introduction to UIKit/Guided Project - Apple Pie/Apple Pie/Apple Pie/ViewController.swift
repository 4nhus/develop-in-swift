//
//  ViewController.swift
//  Apple Pie
//
//  Created by Anh Nguyen on 24/12/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var playerLabel: UILabel!
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7

    var currentRound: Round!
    let players = [Player(name: "Player 1"), Player(name: "Player 2")]
    var currentPlayerIndex = 0
    var currentPlayer: Player {
        players[currentPlayerIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        updateUI()
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentRound = Round(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
        } else {
            enableLetterButtons(false)
        }
    }
    
    func updateUI() {
        let letters = currentRound.formattedWord.map(String.init)
        let wordWithSpacing = letters.joined(separator: " ")
        playerLabel.text = currentPlayer.name
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Score: \(currentPlayer.score), Wins: \(currentPlayer.totalWins), Losses: \(currentPlayer.totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentRound.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        if currentRound.incorrectMovesRemaining == 0 {
            currentPlayer.totalLosses += 1
            newRound()
        } else if currentRound.word == currentRound.formattedWord {
            currentPlayer.score += 1
            currentPlayer.totalWins += 1
            newRound()
        }
    }
    
    func nextPlayer() {
        currentPlayerIndex += 1
        if currentPlayerIndex == players.count {
            currentPlayerIndex = 0
        }
    }
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.titleLabel!.text!
        let letter = Character(letterString.lowercased())
        let correctLettersGuessed = currentRound.makePlayerGuess(letter: letter)
        currentPlayer.score += correctLettersGuessed
        if correctLettersGuessed == 0 {
            nextPlayer()
        }
        updateGameState()
        updateUI()
    }
}

