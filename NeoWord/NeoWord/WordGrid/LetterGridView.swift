//
//  WordGridView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 30/09/24.
//

import SwiftUI

struct LetterGridView: View {
    let columns: [GridItem] = Array(repeating: GridItem(.fixed(60), spacing: 10), count: 5)
    
    // La palabra "today" en las primeras 5 posiciones, las demás vacías
    let letters = ["T", "O", "D", "A", "Y",
                   "T", "R", "U", "N", "K"]
    + Array(repeating: "", count: 20)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
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
