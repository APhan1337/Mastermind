//
//  GuessingGame.swift
//  Mastermind
//
//  Created by Alex Phan on 1/10/23.
//

import SwiftUI

class GuessingGame: ObservableObject {
    @Published var guesses: [Guess] = []
    
    init() {
        startNewGame()
    }
    
    func startNewGame() {
        loadDefault()
    }
    
    func loadDefault() {
        guesses = []
        for index in 0...9 {
            guesses.append(Guess(index: index))
        }
    }
}
