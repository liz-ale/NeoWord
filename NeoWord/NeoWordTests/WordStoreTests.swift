//
//  WordStoreTests.swift
//  NeoWordTests
//
//  Created by lizbeth.alejandro on 04/10/24.
//

import XCTest
@testable import NeoWord

class WordStoreTests: XCTestCase {
    var wordStore: WordStoreManager!

    override func setUp() {
        super.setUp()
        wordStore = WordStoreManager()
    }

    override func tearDown() {
        wordStore = nil
        super.tearDown()
    }

    func testGetRandomWord() async throws {
        // Llamada inicial para obtener una palabra aleatoria (debería cargar los datos)
        let randomWord = try await wordStore.getRandomWord()
        XCTAssertNotNil(randomWord, "La palabra aleatoria no debe ser nil")
        print("Primera palabra aleatoria: \(randomWord)")

        // Segunda llamada para obtener otra palabra (usando cachedWords)
        let anotherRandomWord = try await wordStore.getRandomWord()
        XCTAssertNotNil(anotherRandomWord, "La segunda palabra aleatoria no debe ser nil")
        print("Segunda palabra aleatoria: \(anotherRandomWord)")
        
        // Asegurar que las palabras puedan ser diferentes
        XCTAssertNotEqual(randomWord, anotherRandomWord, "Las palabras aleatorias deben ser diferentes (aunque podrían coincidir por azar)")
    }

    func testExistWord() async throws {
        let word = "abeja"

        // Verificación inicial de la existencia de una palabra
        let exists = try await wordStore.exist(word: word)
        XCTAssertTrue(exists, "La palabra '\(word)' debe existir en la lista")

        // Verificación utilizando los datos almacenados en caché
        let cachedExists = try await wordStore.exist(word: word)
        XCTAssertTrue(cachedExists, "La palabra '\(word)' debe existir en la lista (usando caché)")
    }

    func testNonExistingWord() async throws {
        let word = "noexiste"
        
        // Verificación de que una palabra no existe
        let exists = try await wordStore.exist(word: word)
        XCTAssertFalse(exists, "La palabra '\(word)' no debe existir en la lista")
    }
}
