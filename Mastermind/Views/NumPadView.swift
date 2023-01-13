//
//  NumPadView.swift
//  Mastermind
//
//  Created by Alex Phan on 1/12/23.
//

import SwiftUI

struct NumPadView: View {
    @Binding var input: String
    var body: some View {
        VStack {
            NumPadRowView(keys: ["1", "2", "3"])
            NumPadRowView(keys: ["4", "5", "6"])
            NumPadRowView(keys: ["7", "0", "<"])
        }.environment(\.numberButtonAction, self.keyPressed(_:))
        
    }
    
    private func keyPressed(_ key: String) {
        switch key {
        case "<":
            input.removeLast()
            if input.isEmpty { input = "0" }
        case _ where input == "0": input = key
        default:
            input += key
        }
    }
}

struct NumPadView_Previews: PreviewProvider {
    static var previews: some View {
        NumPadView(input: .constant(""))
    }
}
