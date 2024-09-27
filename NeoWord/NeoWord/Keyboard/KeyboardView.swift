//
//  KeyboardView.swift
//  NeoWord
//
//  Created by julian.garcia on 27/09/24.
//

import SwiftUI

struct KeyboardView: View {
    
    // first row
    let keys1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    let keys2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L", "Ñ"]
    let keys3 = ["Z", "X", "C", "V", "B", "N", "M"]
    
    var body: some View {
        VStack {
            
            HStack(spacing: 8) {
                ForEach(keys1, id: \.self) { key in
                    KeyboardKeyView {
                        Text(key)
                    }
                }
            }
            
            
            HStack(spacing: 8) {
                ForEach(keys2, id: \.self) { key in
                    KeyboardKeyView {
                        Text(key)
                    }
                }
            }
            
            HStack(spacing: 8) {
                // enter
                KeyboardKeyView {
                    Text("ENTER")
                }
                .frame(width: 56)
                
                ForEach(keys3, id: \.self) { key in
                    KeyboardKeyView {
                        Text(key)
                    }
                }
                
                // back
                KeyboardKeyView {
                    Image(systemName: "delete.left")
                }
                .frame(width: 56)
                
            }
            
        }
        .padding(.horizontal, 8)
        .frame(width: .infinity)
    }
}

#Preview {
    KeyboardView()
}
