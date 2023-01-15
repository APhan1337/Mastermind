//
//  GuessingGame.swift
//  Mastermind
//
//  Created by Alex Phan on 1/10/23.
//

import SwiftUI

class GuessingGame: ObservableObject {
    @Published var guesses: [Guess] = []
    
    var computerNumber = ""
    var currentGuess = ""
    var currentRound = 0
    var gameState = false
    var gameOver = false
    var currentFeedback = ""
    var gameResponse: [String] = []
    
    // Disable keyboard whenever game is not in play or if number length is equal to 5
    var disableKeys: Bool {
        !gameState || currentGuess.count == 5
    }
    
    init() {
        startNewGame()
    }
    
    func startNewGame() {
        loadDefault()
        Task {
            computerNumber = try await fetchRandomNumber()
            print(computerNumber)
        }
        currentGuess = ""
        currentFeedback = ""
        currentRound = 0
        gameState = true
    }
    
    func loadDefault() {
        guesses = []
        for index in 0...9 {
            guesses.append(Guess(index: index))
        }
    }
    
//    func fetchRandomNuber()-> String {
//        let url = URL(string: "https://www.random.org/integers/?num=4&min=0&max=7&col=1&base=10&format=plain&rnd=new")
//
//        do {
//            let data = try Data(contentsOf: url!)
//            let result = String(decoding: data, as: UTF8.self).components(separatedBy: "\n").joined()
//            return result
//        } catch {
//            return ""
//        }
//    }
    
    func fetchRandomNumber() async throws -> String{
        let url = URL(string: "https://www.random.org/integers/?num=4&min=0&max=7&col=1&base=10&format=plain&rnd=new")!

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = String(decoding: data, as: UTF8.self).components(separatedBy: "\n").joined()
            return result
        } catch {
            return ""
        }
    }
    
//    func makeHTTPRequest() async {
//        self.result = nil
//        self.result = try await doHTTPRequest()
//    }
//
//    func doHTTPRequest() async -> Result<String, Error> {
//        let url = URL(string: "https://www.random.org/integers/?num=4&min=0&max=7&col=1&base=10&format=plain&rnd=new")!
//        let response = try await URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                return
//            }
//        }
//        return .success(String(data: response.data, encoding: .utf8)!)
//    }
    
    func keyPressed(_ key: String) {
        switch key {
        case "Submit":
            onSubmit()
        case "\u{232B}":
            removeDigitFromCurrentNumber()
        default:
            addToCurrentNumber(key)
        }
    }
    
    func addToCurrentNumber(_ digit: String) {
        currentGuess += digit
        updateRow()
    }
    
    func removeDigitFromCurrentNumber() {
        if (currentGuess.count != 0) {
            currentGuess.removeLast()
        }
        updateRow()
    }
    
    func updateRow() {
        let guessedNumber = currentGuess.padding(toLength: 4, withPad: " ", startingAt: 0)
        guesses[currentRound].number = guessedNumber
    }
    
    func verifyNumber() -> Bool {
        return (currentGuess == computerNumber)
    }
    
    func feedback() {
        var set = Set<Character>()
        let squeezed = currentGuess.filter{ set.insert($0).inserted }
        for i in 0...3 {
            if (currentGuess[currentGuess.index(currentGuess.startIndex, offsetBy: i)] == computerNumber[computerNumber.index(computerNumber.startIndex, offsetBy: i)]) {
                currentFeedback += "!"
            } else if (squeezed.contains(String(computerNumber[computerNumber.index(computerNumber.startIndex, offsetBy: i)]))) {
                currentFeedback += "?"
            }
        }
    }
    
    func onSubmit() {
        feedback()
        guesses[currentRound].feedback = currentFeedback
        if verifyNumber() {
            gameOver = true
            gameState = false
        } else {
            currentRound += 1
            currentGuess = ""
            currentFeedback = ""
            if currentRound == 10 {
                gameOver = true
                gameState = false
            }
        }
    }
}
