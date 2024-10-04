//
//  WordStoreTests.swift
//  NeoWordTests
//
//  Created by lizbeth.alejandro on 04/10/24.
//

import XCTest
@testable import NeoWord

class WordStoreTests: XCTestCase {
    var wordStore: WordStoreManagement!

        override func setUp() {
            super.setUp()
            wordStore = WordStoreManagement() // Inicializa la clase que deseas probar
        }

        override func tearDown() {
            wordStore = nil
            super.tearDown()
        }

        // Prueba para obtener una palabra aleatoria
        func testGetRandomWord() async throws {
            let randomWord = try await wordStore.getRandomWord()
            XCTAssertNotNil(randomWord, "La palabra aleatoria no debe ser nil")
            print("Palabra aleatoria: \(randomWord)")
        }

        // Prueba para verificar si una palabra existe
        func testExistWord() async throws {
            let word = "banana"
            let exists = try await wordStore.exist(word: word)
            XCTAssertTrue(exists, "La palabra '\(word)' debe existir en la lista")
        }
}
