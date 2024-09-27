//
//  KeyView.swift
//  NeoWord
//
//  Created by julian.garcia on 27/09/24.
//

import SwiftUI

struct KeyboardKeyView<T>: View where T : View {
    
    @State var color: Color = Color.gray.opacity(0.2)
    
    @State private var state: Int = 0
    
    var key: () -> T
    
    var body: some View {
        Button {
            setState()
        } label: {
            key()
                .font(.system(size: 24, weight: .bold))
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .padding(4)
                .foregroundStyle(.black)
                .frame(maxWidth: 60, maxHeight: 60)
                .background(color)
                .clipShape(.buttonBorder)
//                            .overlay {
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(lineWidth: 1)
//                                    .foregroundStyle(.black)
//                            }
        }
    }
    
    private func setState() {
        let nextState = state + 1
        
        state = nextState % 4
 
        print(state)
        
        withAnimation {
            color = switch state {
            case 0:
                Color.gray.opacity(0.2)
            case 1:
                Color.yellow
            case 2:
                Color.green
            default:
                Color.gray
            }
        }
    }
}

#Preview {
    KeyboardKeyView { Text("A") }
}
