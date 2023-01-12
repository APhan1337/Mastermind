//
//  Guess.swift
//  Mastermind
//
//  Created by Alex Phan on 1/10/23.
//

import SwiftUI

struct Guess {
    let index: Int
    var number = "    "
    var digit: [String] {
        number.map { String($0) }
    }
}

