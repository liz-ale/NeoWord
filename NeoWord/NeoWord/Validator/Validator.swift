//
//  Validator.swift
//  NeoWord
//
//  Created by julian.garcia on 02/10/24.
//

import Foundation

protocol Validator {
    func validate(_ input: String) async throws -> [LetterBox]
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
        
    var db = "thank"
    
    func validate(_ input: String) async throws -> [LetterBox] {
        print("validating: \(input)")
        /*
         1. verificar que exista
         2. validar letras
            - contiene letra
            - pos
         3. modificar estado
         
         */
        
        
        let letterStates: [LetterBox] = input.map { char in
                .init(letter: String(char), state: LetterBoxState.random)
        }
        
        return letterStates
    }
    
}
