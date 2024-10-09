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
                KeyboardView(viewModel: viewModel)
            }
            
            // Mostrar el CustomDialog al terminar el juego
            if viewModel.showAlert {
                CustomDialog(
                    isActive: $viewModel.showAlert,
                    title: viewModel.dialogMessage,
                    message: "",
                    buttonTitle: "Empezar de nuevo",
                    action: {
                        viewModel.reset()
                    },
                    // Determinar la animacion: ¿fue victoria?
                    isVictory: viewModel.gameState == .finished(didWin: true)
                )
            }
        }
    }
    
    var topBar: some View {
        ZStack {
            HStack {
                menu
                Spacer()
            }
            Text("NeoWord")
                .font(.title)
                .fontWeight(.bold)
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
