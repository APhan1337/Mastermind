//
//  GuessingGame.swift
//  Mastermind
//
//  Created by Alex Phan on 1/10/23.
//

import SwiftUI

/**
 * Create a class that conforms to the ObservableObject protocol, which indicates that a class has properties that should
 * be monitored for changes.
 * @prop {Guess array} guesses - marked with Published to monitor for changes and send change notifications to SwiftUI when the property is changed
 * @prop {String} computerNumber - randomly generated number (computer's number)
 * @prop {String} currentGuess - the user's guess, which will be build
 * @prop {Integer} currentRound - keep track of what row/round we are on; to update Guess object with currentGuess
 * @prop {Boolean} gameState - keep track of certain game states (adding more than 4 digits to guess, backspacing digits when no digits to delete, submitting when less than 4 digits)
 * @prop {Boolean} gameOver -
 * @prop {String} currentFeedback - output to user how many digits they got right and how many in the right position
 * @prop {String array} gameResponse - 
 * @prop {Boolean} disableKeys - computed property that is true whenever game state is not in play or when current guess length is not equal to 4
 */
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
        !gameState || currentGuess.count == 4
    }
    
    // Initializer that calls startNewGame function
    init() {
        startNewGame()
    }
    
    /**
     * Starts a new game by:
     * 1. Loading default values
     * 2. Fetching the "computer's number" through API request
     * 3. Reseting guessing game properties
     */
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
    
    // Refresh values at the start of game with defaults
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
    
    /**
     * Use Async/Await in SwiftUI and MVVM architecture to make an HTTP request and update computer's number
     * (Reference link: https://medium.com/@engineermuse/mvvm-pattern-in-swiftui-using-async-await-5b97f08e7c74)
     */
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

//    func doHTTPRequest() async -> Result<String, Error> {
//        let url = URL(string: "https://www.random.org/integers/?num=4&min=0&max=7&col=1&base=10&format=plain&rnd=new")!
//        let response = try await URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                return
//            }
//        }
//        return .success(String(data: response.data, encoding: .utf8)!)
//    }
    
    /* Gameplay logic */
    
    //
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
    
    // Appends a String (single digit character) to user's current guess
    func addToCurrentNumber(_ digit: String) {
        currentGuess += digit
        updateRow()
    }
    
    // Whenever backspace is hit, remove the last letter in the guess
    func removeDigitFromCurrentNumber() {
        if (currentGuess.count != 0) {
            currentGuess.removeLast()
        }
        updateRow()
    }
    
    /**
     * Make sure that the "guess" we assign to our guessed number in our row is 4 characters long.
     * Pad our current guess with spaces
     */
    func updateRow() {
        // Create a "new" number by padding the user's current guess to a length of 4 with a SPACE starting at index 0
        let guessedNumber = currentGuess.padding(toLength: 4, withPad: " ", startingAt: 0)
        // Apply the "new" number to the guess array's number
        guesses[currentRound].number = guessedNumber
    }
    
    // Checks if current guess matches computer's number
    func verifyNumber() -> Bool {
        return (currentGuess == computerNumber)
    }
    
    /**
     * Appends "!" or "?" by comparing each digit from user's guess and computer's number.
     */
    func feedback() {
        // Create a unique String of user's guess (no duplicates)
        var set = Set<Character>()
        let squeezed = currentGuess.filter{ set.insert($0).inserted }
        
        // Iterate through current guess and compares it with computer's number.
        // If user's digit is in the same index as computer's digit, then feedback a "!".
        // If "new" no-duplicates user's guess does not contain the digit at index of computer's number, then feedback a "?"
        for i in 0...3 {
            // Basically attempting to check if currentGuess[i] == computerNumber[i]
            if (currentGuess[currentGuess.index(currentGuess.startIndex, offsetBy: i)] == computerNumber[computerNumber.index(computerNumber.startIndex, offsetBy: i)]) {
                currentFeedback += "!"
            } else if (squeezed.contains(String(computerNumber[computerNumber.index(computerNumber.startIndex, offsetBy: i)]))) {
                currentFeedback += "?"
            }
        }
    }
    
    /**
     * Whenever the submit button is hit:
     * 1. Check if user's guess matches computer's number
     * 2. Update guess object's feedback string
     * 3. Update game state if user's guess matches computer's number
     * 4. Else wrong guess, then update game properties
     */
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
