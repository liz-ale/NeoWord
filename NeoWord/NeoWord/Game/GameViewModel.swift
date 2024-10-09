//
//  gameViewModel.swift
//  NeoWord
//
//  Created by julian.garcia on 02/10/24.
//

import Foundation
import SwiftUI

enum GameState {
    case playing
    case finished(didWin: Bool)
    
    var isPlaying: Bool {
        switch self {
        case .playing: true
        case .finished: false
        }
    }
}

@Observable
final class GameViewModel {
    
    private let gameValidator: GameValidator
    
    private let wordManager: WordStoreManager
    
    // game state
    var gameState = GameState.playing
    
    var currentWord: String = ""
    
    var grid = [LetterBox]()
    
    var keyboardStates = [String : LetterBoxState]()
    
    var round = 1
    
    var showAlert: Bool = false
    
    var dialogMessage: String {
        switch gameState {
        case .playing: "Round \(round)"
        case .finished(didWin: let didWin):
            didWin ? "Ganasteee!" : "Perdisteee!"
        }
    }
    
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
        guard gameState.isPlaying else { return }
        
        let q = (round * 5) - 1
        let p = q - 4
        let currentPosition = grid.count
        
        if letter == "DELETE" {
            deletePressed(
                currentPosition: currentPosition,
                firstIndex: p
            )
        } else if letter == "ENTER" {
            enterPressed(
                currentPosition: currentPosition,
                firstIndex: p,
                lastIndex: q
            )
            
        } else {
            // letter pressed
            letterPressed(
                letter: letter,
                currentPosition: currentPosition,
                lastIndex: q
            )
        }
    }
    
    func reset() {
        grid.removeAll()
        keyboardStates.removeAll(keepingCapacity: true)
        
        gameState = .playing
        round = 1
        
        start()
    }
    
    private func deletePressed(currentPosition: Int, firstIndex p: Int) {
        if currentPosition > p {
            grid.removeLast()
        }
    }
    
    private func letterPressed(letter: String, currentPosition: Int, lastIndex q: Int) {
        if currentPosition <= q {
            grid.append(LetterBox(letter: letter))
        }
    }
    
    private func enterPressed(currentPosition: Int, firstIndex p: Int, lastIndex q: Int) {
        if currentPosition == q + 1 {
            
            let word = grid[p...q].map { $0.letter ?? "" }.joined()
            
            Task(priority: .high) {
                // update grid
                let validations = try await gameValidator.validate(word, with: currentWord)
                
                
                Task { @MainActor in
                    
                    guard !validations.isEmpty else {
                        print("No se encontró la palabra ingresada")
                        return
                    }

                    var x = 0
                    for i in p...q {
                        grid[i].state = validations[x].state
                        // Disparar la animación de rebote
                                            grid[i].isAnimating = true
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
//                            print("\(letter): \(oldState) -> \(newState)")
                            
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
//                            print("\(letter) -> \(newState)")
                            newKeyboardStates[letter] = newState
                        }
                    }
                    
                    keyboardStates = newKeyboardStates
//                    print("keyboardStates:")
//                    dump(keyboardStates)
                    
                    let finished = validations.reduce(into: true) { partialResult, element in
                        partialResult = partialResult && element.state == .correctPosition
                    }
                    
                    if finished {
                        gameState = .finished(didWin: true)
                        showAlert = true
                    } else if round == 6 {
                        gameState = .finished(didWin: false)
                        showAlert = true
                    }
                    
                    
                    round += round < 6 ? 1 : 0
                }
            }
        }
    }
   
    
}
