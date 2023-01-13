//
//  NumberButtonView.swift
//  Mastermind
//
//  Created by Alex Phan on 1/12/23.
//

import SwiftUI

struct NumberButtonView: View {
    @EnvironmentObject var gameViewModel: GuessingGame
    var key: String
    var body: some View {
        Button(action: { self.action(self.key) }) {
            Color.clear
                //.overlay(RoundedRectangle(cornerRadius: 12)
                //                    .stroke(Color.accentColor))
                .overlay(Text(key))
        }
    }
    
    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }
    
    @Environment(\.numberButtonAction) var action: (String) -> Void
}

extension EnvironmentValues {
    var numberButtonAction: (String) -> Void {
        get { self[NumberButtonView.ActionKey.self] }
        set { self[NumberButtonView.ActionKey.self] = newValue }
    }
}

struct NumberButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NumberButtonView(key: "1")
            .environmentObject(GuessingGame())
    }
}
