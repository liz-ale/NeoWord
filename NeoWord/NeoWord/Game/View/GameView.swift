//
//  GameView.swift
//  NeoWord
//
//  Created by julian.garcia on 02/10/24.
//

import SwiftUI

struct GameView: View {
    @State var viewModel = GameViewModel()
    
    var menu: some View {
        Menu {
            Button("Restart", role: .destructive, action: viewModel.reset)
        } label: {
            Label("Options", systemImage: "ellipsis.circle")
                .font(.title)
                .labelStyle(.iconOnly)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer(minLength: 20)
                    LetterGridView(grid: viewModel.grid)
                    Spacer(minLength: 20)
                    KeyboardView(viewModel: viewModel)
                    Spacer(minLength: 20)
                } .ignoresSafeArea(edges: .bottom)
                
                if viewModel.showAlert {
                    CustomDialog(
                        isActive: $viewModel.showAlert,
                        title: "¡El juego ha terminado!" ,
                        message: viewModel.dialogMessage,
                        buttonTitle: "Empezar de nuevo",
                        action: {
                            viewModel.reset()
                        },
                        isVictory: viewModel.gameState == .finished(didWin: true)
                    )
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    menu
                }
                ToolbarItem(placement: .principal) {
                    Text("NeoWord")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                }
            }
        }
        .navigationViewStyle(.stack)
    }

}


#Preview {
    GameView()
}
