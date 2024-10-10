//
//  WordGridView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 30/09/24.
//

import SwiftUI

struct LetterGridView: View {
    
    var grid: [LetterBox]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<6) { row in
                HStack(spacing: 10) {
                    ForEach(0..<5) { column in
                        let index = row * 5 + column
                        if index < grid.count {
                            LetterBoxView(letterBox: grid[index])
                        } else {
                            LetterBoxView(letterBox: nil)
                        }
                    }
                }
            }
        }
        .frame(width: Global.boardWidth, height: 6 * Global.boardWidth / 5 )
        .padding()
    }
}


#Preview {
    LetterGridView(grid: [])
}
