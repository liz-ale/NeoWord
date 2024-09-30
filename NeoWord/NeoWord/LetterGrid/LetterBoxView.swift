//
//  LetterBoxView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 30/09/24.
//

import SwiftUI

struct LetterBoxView: View {
    var letter: String
    
    var body: some View {
        Text(letter)
            .frame(width: 50, height: 50)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)
            .font(.title)
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}
