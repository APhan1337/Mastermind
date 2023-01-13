//
//  ContentView.swift
//  Mastermind
//
//  Created by Alex Phan on 1/6/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameViewModel: GuessingGame
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    VStack(spacing: 3) {
                        ForEach(0...9, id:\.self) { index in
                            GuessView(guess: $gameViewModel.guesses[index])
                        }
                    }
                    .frame(width: geometry.size.width, height: 10 * geometry.size.width / 4)
                }
                .frame(width: UIScreen.main.bounds.width - 200)
                Divider()
                NumPadView(input: .constant(""))
                Button("Submit") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
            }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            
                        } label: {
                            Image(systemName: "questionmark.circle")
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("NO.DLE")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .tracking(10)
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
//    let _ = print(Screen.boardWidth)
//    print(10 * Screen.boardWidth / 4)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GuessingGame())
    }
}
