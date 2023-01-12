//
//  MastermindApp.swift
//  Mastermind
//
//  Created by Alex Phan on 1/6/23.
//

import SwiftUI

@main
struct MastermindApp: App {
    @StateObject var gameViewModel = GuessingGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameViewModel)
        }
    }
}
