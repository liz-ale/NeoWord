//
//  KeyView.swift
//  NeoWord
//
//  Created by julian.garcia on 27/09/24.
//

import SwiftUI

struct KeyboardKey<KeyLabel>: View where KeyLabel : View {
    
    var state: LetterBoxState
    
    var action: () -> Void
    
    var keyLabel: () -> KeyLabel
    
    var body: some View {
        Button {
            action()
        } label: {
            keyLabel()
                .font(.system(size: 24, weight: .bold))
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .padding(4)
                .foregroundStyle(.black)
                .frame(maxWidth: 60, maxHeight: 60)
                .background(color)
                .clipShape(.buttonBorder)
        }
    }
    
    private var color: Color {
        switch state {
        case .empty:
            Color.gray.opacity(0.2)
        case .wrongPosition:
            Color.yellow
        case .good:
            Color.green
        case .wrongLetter:
            Color.gray
        }
    }
}

#Preview {
    KeyboardKey(
        state: .empty,
        action: {},
        keyLabel: { Text("") }
    )
}
