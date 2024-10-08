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
        ZStack {
            VStack {
                topBar
                LetterGridView(grid: viewModel.grid)
                KeyboardView(
                    viewModel: viewModel
                )
            }
            
            if viewModel.showAlert {
                CustomDialog(
                    isActive: $viewModel.showAlert,
                    title: "El juego ha terminado!",
                    message: viewModel.dialogMessage,
                    buttonTitle: "Empezar de nuevo",
                    action: viewModel.reset
                )
            }
        }
    }
    
    var topBar: some View {
        HStack(alignment: .top) {
            menu
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    var menu: some View {
        Menu {
            Button("Restart", role: .destructive, action: viewModel.reset)
        } label: {
            Label("Options", systemImage: "ellipsis.circle")
                .font(.title)
                .labelStyle(.iconOnly)
        }
    }
}

#Preview {
    GameView()
}
