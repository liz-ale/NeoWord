//
//  Validator.swift
//  NeoWord
//
//  Created by julian.garcia on 02/10/24.
//

import Foundation

protocol Validator {
    func validate(_ input: String, with currentWord: String) async throws -> [LetterBox]
}

//protocol WordStore {
//    func getRandomWord() async throws -> String
//    func exist(word: String) async throws -> Bool
//}
//
//class WordStoreManager: WordStore {
//    func getRandomWord() async throws -> String {
//        "thank"
//    }
//    func exist(word: String) async throws -> Bool {
//        true
//    }
//}

final class GameValidator: Validator {
    
    var wordStore: WordStore
    
    init(
        wordStore: WordStore = WordStoreManager()
    ) {
        self.wordStore = wordStore
    }
    
    func validate(_ input: String, with currentWord: String) async throws -> [LetterBox] {
        assert(input.count == 5) // number of letters
        assert(currentWord.count == 5)
        
//        print("validating: \(input)")
        
        // 1. validate word exists
        guard try await wordStore.exist(word: input) else {
            // word do not exist
            return []
        }
        
        var letterStates = [LetterBox]()
        
        // get arrays for easy manipulation
        let inputArray = Array(input.uppercased())
        let currentWordArray = Array(currentWord.uppercased())
        
        // sets for getting the common letters
        let inputLetters = Set(inputArray)
        let currentWordLetters = Set(currentWordArray)
        let commonLetters = inputLetters.intersection(currentWordLetters)
        
        inputArray.enumerated().forEach { i, letter in
            if commonLetters.contains(letter)  {
                letterStates.append(
                    .init(
                        letter: String(letter),
                        state: letter == currentWordArray[i] ? .correctPosition : .wrongPosition
                    )
                )
            } else {
                letterStates.append(
                    .init(
                        letter: String(letter),
                        state: .wrongLetter
                    )
                )
            }
        }
        
        return letterStates
    }
    
}
