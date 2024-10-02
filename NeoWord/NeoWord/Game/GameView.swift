//
//  GameView.swift
//  NeoWord
//
//  Created by julian.garcia on 02/10/24.
//

import SwiftUI

struct GameView: View {
    @State var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            LetterGridView(grid: viewModel.grid)
            KeyboardView(
                viewModel: viewModel
            )
        }
    }
}

#Preview {
    GameView()
}
