//
//  WordStoreManagement.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 04/10/24.
//

import Foundation

protocol WordStore {
    func getRandomWord() async throws -> String
    func exist(word: String) async throws -> Bool
}

enum WordStoreError: Error {
    case fileNoteFound
    case dataCorrupted
    case decodingFailed
}

class WordStoreManagement: WordStore {
    private var cachedWords: Words?

    func getData() throws -> Words {
        if let cachedWords = cachedWords {
            return cachedWords
        }

        guard let url = Bundle.main.url(forResource: "BankWord", withExtension: "json") else {
            throw WordStoreError.fileNoteFound
        }
        let data = try Data(contentsOf: url)
        let words = try JSONDecoder().decode(Words.self, from: data)

        cachedWords = words
        return words
    }

    func getRandomWord() async throws -> String {
        let wordsData = try cachedWords ?? getData()
        guard let randomWord = wordsData.words.randomElement() else {
            throw WordStoreError.dataCorrupted
        }
        return randomWord
    }
    
    func exist(word: String) async throws -> Bool {
        let wordsData = try cachedWords ?? getData()
        return wordsData.words.contains(word)
    }
}
