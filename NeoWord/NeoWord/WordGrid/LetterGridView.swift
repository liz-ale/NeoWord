//
//  WordGridView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 30/09/24.
//

import SwiftUI

struct LetterGridView: View {
    
    var grid: [LetterBox]
    
    let columns: [GridItem] = Array(repeating: GridItem(.fixed(60), spacing: 10), count: 5)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(0..<30, id: \.self) { index in
                if index < grid.count {
                    LetterBoxView(letterBox: grid[index])
                } else {
                    LetterBoxView(letterBox: nil)
                }
            }
        }
        .padding()
    }
}

#Preview {
    LetterGridView(grid: [])
}
