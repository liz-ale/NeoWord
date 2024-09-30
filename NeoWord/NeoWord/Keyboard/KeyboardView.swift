//
//  KeyboardView.swift
//  NeoWord
//
//  Created by julian.garcia on 27/09/24.
//

import SwiftUI

struct KeyboardView: View {
    
    @State var pressedKey: String? = nil
    
    let keys1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    let keys2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L", "Ñ"]
    let keys3 = ["Z", "X", "C", "V", "B", "N", "M"]
    
    var body: some View {
        VStack {
            // First row
            HStack(spacing: 8) {
                ForEach(keys1, id: \.self) { key in
                    KeyboardKey {
                        pressKey(key)
                    } keyLabel: {
                        Text(key)
                    }
                }
            }
            
            // Second row
            HStack(spacing: 8) {
                ForEach(keys2, id: \.self) { key in
                    KeyboardKey {
                        pressKey(key)
                    } keyLabel: {
                        Text(key)
                    }
                }
            }
            
            // Third row
            HStack(spacing: 8) {
                // enter
                KeyboardKey {
                    pressKey("ENTER")
                } keyLabel: {
                    Text("ENTER")
                }
                .frame(width: 56)
                
                ForEach(keys3, id: \.self) { key in
                    KeyboardKey {
                        pressKey(key)
                    } keyLabel: {
                        Text(key)
                    }
                }
                
                // back
                KeyboardKey {
                    pressKey("DELETE")
                } keyLabel: {
                    Image(systemName: "delete.left")
                }
                .frame(width: 56)
            }
        }
        .padding(.horizontal, 8)
    }
    
    func pressKey(_ key: String) {
        print("Pressed key: \(key)")
        self.pressedKey = key
    }
}

#Preview {
    KeyboardView()
}
