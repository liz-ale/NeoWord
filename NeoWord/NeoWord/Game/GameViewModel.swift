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
    
    private let wordManager: WordStoreManager
    
    // game state
    var currentWord: String = ""
    
    var grid = [LetterBox]()
    
    var keyboardStates = [String : LetterBoxState]()
    
    var round = 1
    
    init(
        gameValidator: GameValidator = .init(),
        wordManager: WordStoreManager = .init(),
        grid: [LetterBox] = .init()
    ) {
        self.gameValidator = gameValidator
        self.wordManager = wordManager
        self.grid = grid
        
        
        // start game
        start()
    }
    
    private func start() {
        Task {
            let newWord = try await wordManager.getRandomWord()
            
            Task { @MainActor in
                self.currentWord = newWord
            }
        }
    }
    
    
    func appendLetter(letter: String) {
        let q = (round * 5) - 1
        let p = q - 4
        let currentPosition = grid.count
        
        if letter == "DELETE" {
            if currentPosition > p {
                grid.removeLast()
            }
        } else if letter == "ENTER" {
            if currentPosition == q + 1 {
                // TODO: VALIDATE
                
                let word = grid[p...q].map { $0.letter ?? "" }.joined()
                
                Task(priority: .high) {
                    // update grid
                    let validations = try await gameValidator.validate(word, with: currentWord)
                    
                    guard !validations.isEmpty else {
                        print("No se encontró la palabra ingresada")
                        return
                    }
                    
                    Task { @MainActor in
                        var x = 0
                        for i in p...q {
                            grid[i].state = validations[x].state
                            x += 1
                        }
                        
                        var newKeyboardStates = keyboardStates
                        
                        // update keyboard
                        validations.forEach { validation in
                            
                            let newState = validation.state
                            
                            guard let letter = validation.letter else {
                                return
                            }
                            
                            if let oldState = newKeyboardStates[letter] {
                                print("\(letter): \(oldState) -> \(newState)")
                                
                                switch oldState {
                                case .correctPosition:
                                    break
                                case .wrongPosition:
                                    if newState == .correctPosition {
                                        // actualizar estado al nuevo
                                        newKeyboardStates[letter] = newState
                                    }
                                case .wrongLetter:
                                    break
                                case .empty:
                                    newKeyboardStates[letter] = newState
                                }
                                
                            } else {
                                print("\(letter) -> \(newState)")
                                newKeyboardStates[letter] = newState
                            }
                        }
                        
                        keyboardStates = newKeyboardStates
                        print("keyboardStates:")
                        dump(keyboardStates)
                        
                        round += round < 6 ? 1 : 0
                    }
                }
            }
        } else {
            // letra
            if currentPosition <= q {
                grid.append(LetterBox(letter: letter))
            }
        }
    }
}
