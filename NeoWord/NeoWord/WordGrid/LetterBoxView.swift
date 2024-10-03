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
    
    @State private var currentState: LetterState = .idle
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        Text(letterBox?.letter ?? "")
            .frame(width: 60, height: 60)
            .background(backgroundColor)
            .cornerRadius(5)
            .font(.title)
            .foregroundColor(textColor)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .scaleEffect(scale)
            .onTapGesture {
                triggerAnimation()
            }
            .animation(.easeInOut(duration: 0.3), value: scale)
            .animation(.easeInOut(duration: 0.3), value: currentState)
    }
    
    //Cambiar color según estado actual
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
        
        
//        switch currentState {
//        case .idle:
//            return Color.white
//        case .zoom:
//            return Color.gray.opacity(0.2)
//        case .grayBackground:
//            return Color.gray
//        case .greenBackground:
//            return Color.green
//        case .yellowBackground:
//            return Color.yellow
//        }
    }
    
    // Cambiar color del texto según estado actual
    private var textColor: Color {
        switch currentState {
        case .idle, .zoom:
            return Color.black
        case .grayBackground, .greenBackground, .yellowBackground:
            return Color.white
        }
    }
    
    // Activar la animación y cambiar el estado
    private func triggerAnimation() {
        switch currentState {
        case .idle:
            withAnimation {
                scale = 0.8 // Zoom out
                currentState = .zoom
            }
            withAnimation(Animation.easeInOut(duration: 0.3).delay(0.3)) {
                scale = 1.1 // Zoom in
            }
        case .zoom:
            currentState = .grayBackground
        case .grayBackground:
            currentState = .greenBackground
        case .greenBackground:
            currentState = .yellowBackground
        case .yellowBackground:
            currentState = .idle
        }
    }
}

#Preview {
    LetterBoxView(letterBox: .init(letter: "A", state: .correctPosition))
}

