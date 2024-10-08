//
//  LetterBoxView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 30/09/24.
//

import SwiftUI

enum LetterState {
    case idle
    case zoom
    case grayBackground
    case greenBackground
    case yellowBackground
}

struct LetterBoxView: View {
    var letterBox: LetterBox?
    
    @State private var scale: CGFloat = 1.0
    @State private var borderColor: Color = .gray
    
    var body: some View {
        Text(letterBox?.letter ?? "")
            .frame(width: 60, height: 60)
            .background(backgroundColor)
            .cornerRadius(5)
            .font(.title)
            .foregroundColor(textColor) // Se ajusta el color del texto
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: 2)
            )
            .scaleEffect(scale)
            .onAppear {
                triggerAnimation() // Iniciar la animación cuando aparezca la letra
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3), value: scale)
            .animation(.easeInOut(duration: 0.3), value: borderColor)
    }
    
    // Cambiar color según estado actual
    private var backgroundColor: Color {
        guard let letterBox = letterBox else { return .white }
        
        return switch letterBox.state {
        case .empty:
            Color.white
        case .correctPosition:
            Color.green
        case .wrongPosition:
            Color.yellow
        case .wrongLetter:
            Color.gray
        }
    }
    
    // Cambiar color del texto según el estado
    private var textColor: Color {
        guard let letterBox = letterBox else { return Color.black }
        
        // El texto es negro mientras se ingresa la letra (estado vacío)
        return letterBox.state == .empty ? Color.black : Color.white
    }
    
    // Activar animación de respiración
    private func triggerAnimation() {
        withAnimation {
            scale = 0.8
            borderColor = .gray
        }

        // Restaurar al tamaño original
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                scale = 1.0
            }
        }
    }
}

#Preview {
    LetterBoxView(
        letterBox: .init(letter: "A", state: .correctPosition)
    )
}

