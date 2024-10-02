//
//  ContentView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 27/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            LetterGridView()
            KeyboardView()
        }
    }
}

#Preview {
    ContentView()
}
