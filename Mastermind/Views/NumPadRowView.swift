//
//  NumPadRowView.swift
//  Mastermind
//
//  Created by Alex Phan on 1/12/23.
//

import SwiftUI

struct NumPadRowView: View {
    var keys: [String]
    var body: some View {
        HStack {
            ForEach(keys, id: \.self) { key in
                NumberButtonView(key: key)
            }
        }
        .frame(height: UIScreen.main.bounds.width / 7)
    }
}

struct NumPadRowView_Previews: PreviewProvider {
    static var previews: some View {
        NumPadRowView(keys: [""])
    }
}
