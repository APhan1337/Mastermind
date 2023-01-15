//
//  NumPadView.swift
//  Mastermind
//
//  Created by Alex Phan on 1/12/23.
//

import SwiftUI

struct NumPadView: View {
    //@Binding var input: String
    @EnvironmentObject var gameViewModel: GuessingGame
    var body: some View {
        VStack {
            NumPadRowView(keys: ["1", "2", "3"])
            NumPadRowView(keys: ["4", "5", "6"])
            NumPadRowView(keys: ["7", "0", "\u{232B}"])
            Button("Submit") {
                gameViewModel.keyPressed("Submit")
            }
            .disabled(gameViewModel.currentGuess.count < 4 || !gameViewModel.gameState)
        }.environment(\.numberButtonAction, self.onKeyPressed(_:))
    }// ⌫
    
    private func onKeyPressed(_ key: String) {
        if (gameViewModel.currentGuess.count < 4) {
            gameViewModel.keyPressed(key)
        }
    }
}

struct NumPadView_Previews: PreviewProvider {
    static var previews: some View {
        NumPadView()
            .environmentObject(GuessingGame())
    }
}
