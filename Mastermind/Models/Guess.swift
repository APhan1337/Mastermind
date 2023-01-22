//
//  Guess.swift - Model with default values that reflect the state of the Guess
//                before any numbers are entered
//  Mastermind
//
//  Created by Alex Phan on 1/10/23.
//

import SwiftUI

/**
 *  Guess struct to store the different data types for a Guess
 *  @prop {Integer} index - for each guess, we need to know user's guess attempt #
 *  @prop {String} number - the user's input, a 4 digit String
 *  @prop {String Array} digit - break user's input into an array of Strings
 *  @prop {String} feedback - the computer's response to user's input
 */
struct Guess {
    let index: Int                  // index is created when we create the object and it never changes
    var number = "    "
    var digit: [String] {           // Split word into an array to iterate and do comparisons
        number.map { String($0) }
    }
    var feedback = ""
}

