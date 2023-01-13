//
//  GuessingGame.swift
//  Mastermind
//
//  Created by Alex Phan on 1/10/23.
//

import SwiftUI

struct RandomNumber: Codable {
    var num: Int = 4
    var min: Int = 0
    var max: Int = 7
    var col: Int = 1
    var base: Int = 10
    var format: String = "plain"
    var rnd: String = "new"
}

class GuessingGame: ObservableObject {
    @Published var guesses: [Guess] = []
    @Published var randomNumber: [RandomNumber] = []
    
    var selectedNumber = ""
    var userInput = ""
    var currentRound = 0
    
    
    init() {
        startNewGame()
    }
    
    func startNewGame() {
        loadDefault()
        selectedNumber = "0123"
        userInput = ""
    }
    
    func loadDefault() {
        guesses = []
        for index in 0...9 {
            guesses.append(Guess(index: index))
        }
    }
    
    func fetchRandomNuber() async {
        guard let url = URL(string: "https://www.random.org/integers/") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let response = try? JSONDecoder().decode([RandomNumber].self, from: data) {
                randomNumber = response
            }
        } catch {
            return
        }
    }
    
    func addToCurrentNumber(_ digit: String) {
        userInput += digit
        updateRow()
    }
    
    func updateRow() {
        let guessedNumber = userInput.padding(toLength: 4, withPad: " ", startingAt: 0)
        guesses[currentRound].number = guessedNumber
    }
    
    func removeDigitFromCurrentNumber() {
        userInput.removeLast()
        updateRow()
    }
    
}
