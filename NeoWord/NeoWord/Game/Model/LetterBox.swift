//
//  LetterBox.swift
//  NeoWord
//
//  Created by julian.garcia on 02/10/24.
//


struct LetterBox: Equatable {
    var letter: String? = nil
    var state: LetterBoxState = .empty
    var isAnimating: Bool = false
}

enum LetterBoxState: CaseIterable {
    case empty
    case correctPosition
    case wrongPosition
    case wrongLetter
    
    static var random: LetterBoxState {
        Self.allCases.randomElement()!
    }
}
