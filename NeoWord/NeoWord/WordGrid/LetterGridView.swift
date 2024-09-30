//
//  WordGridView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 30/09/24.
//

import SwiftUI

struct LetterGridView: View {
    let columns: [GridItem] = Array(repeating: .init(.fixed(50)), count: 5) //columnas
    let letters = Array(repeating: "", count: 30) // casillas
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(letters.indices, id: \.self) { index in
                LetterBoxView(letter: letters[index])
            }
        }
        .padding()
    }
}

#Preview {
    LetterGridView()
}
