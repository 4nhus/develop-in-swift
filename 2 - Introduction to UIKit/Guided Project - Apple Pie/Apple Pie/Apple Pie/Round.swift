//
//  Round.swift
//  Apple Pie
//
//  Created by Anh Nguyen on 24/12/2024.
//

import Foundation

struct Round {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func makePlayerGuess(letter: Character) -> Int {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
            return 0
        } else {
            return word.filter { $0 == letter }.count
        }
    }
}
