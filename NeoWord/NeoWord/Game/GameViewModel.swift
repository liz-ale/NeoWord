//
//  gameViewModel.swift
//  NeoWord
//
//  Created by julian.garcia on 02/10/24.
//

import Foundation
import SwiftUI

@Observable
final class GameViewModel {
    
    private let gameValidator: GameValidator
    
    // game state
    var grid = [LetterBox]()
    
    var keyboardStates = [String : LetterBoxState]()
    
    var round = 1
    
    init(
        gameValidator: GameValidator = .init(),
        grid: [LetterBox] = .init()
    ) {
        self.gameValidator = gameValidator
        self.grid = grid
    }
    
    
    func appendLetter(letter: String) {
        let q = (round * 5) - 1
        let p = q - 4
        let currentPosition = grid.count
        
        print("Current letter: \(letter)")
        
        if letter == "DELETE" {
            if currentPosition > p {
                print("REMOVE PRESSED")
                grid.removeLast()
            }
        } else if letter == "ENTER" {
            if grid.count == q + 1 {
                print("ENTER PRESSED")
                
                // TODO: VALIDATE
                
                let word = grid[p...q].map { $0.letter ?? "" }.joined()
                
                Task {
                    // update grid
                    let validations = try await gameValidator.validate(word)
                    
                    var x = 0
                    for i in p...q {
                        grid[i].state = validations[x].state
                        x += 1
                    }
                    
                    // update keyboard
                    validations.forEach { validation in
                        
                        let newState = validation.state
                        
                        guard let letter = validation.letter else {
                            return
                        }
                        
                        if let oldState = keyboardStates[letter] {
                            switch oldState {
                            case .good:
                                break
                            case .wrongPosition:
                                if newState == .good {
                                    // actualizar estado al nuevo
                                    keyboardStates[letter] = newState
                                }
                            case .wrongLetter:
                                break
                            case .empty:
                                keyboardStates[letter] = newState
                            }
                            
                        } else {
                            keyboardStates[letter] = newState
                        }
                    }
                }
                
                round += round < 6 ? 1 : 0
                
            }
        } else {
            // letra
            if currentPosition <= q {
                grid.append(LetterBox(letter: letter))
            }
        }
    }
}
