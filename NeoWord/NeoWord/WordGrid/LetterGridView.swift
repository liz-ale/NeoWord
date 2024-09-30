//
//  WordGridView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 30/09/24.
//

import SwiftUI

struct LetterGridView: View {
    let columns: [GridItem] = Array(repeating: GridItem(.fixed(60),spacing: 20), count: 5)
    let letters = Array(repeating: "", count: 30)
    
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
