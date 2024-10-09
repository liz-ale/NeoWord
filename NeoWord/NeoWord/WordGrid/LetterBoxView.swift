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
    @State private var offsetY: CGFloat = 0.0
    @State private var borderColor: Color = .gray

    var body: some View {
        Text(letterBox?.letter ?? "")
            .frame(minWidth: 60, minHeight: 60)
            .background(backgroundColor)
            .cornerRadius(5)
            .font(.title)
            .foregroundColor(textColor)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: 2)
            )
            .scaleEffect(scale)
            .offset(y: offsetY)
            .onAppear {
                triggerAnimation()
            }
            
            
            .onChange(of: letterBox?.isAnimating ?? false, perform: { isAnimating in
                if isAnimating {
                    triggerValidationAnimation()
                }
            })
            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3), value: scale)
            .animation(.easeInOut(duration: 0.3), value: borderColor)
            .animation(.spring(), value: offsetY)
    }

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

    private var textColor: Color {
        guard let letterBox = letterBox else { return Color.black }
        return letterBox.state == .empty ? Color.black : Color.white
    }

    private func triggerAnimation() {
        withAnimation {
            scale = 0.8
            borderColor = .gray
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                scale = 1.0
            }
        }
    }

    private func triggerValidationAnimation() {
        withAnimation {
            offsetY = -10
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.spring()) {
                offsetY = 0
            }
        }
    }
}

#Preview {
    LetterBoxView(
        letterBox: .init(letter: "A", state: .correctPosition)
    )
}

