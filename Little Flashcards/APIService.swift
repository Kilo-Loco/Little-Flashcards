//
//  APIService.swift
//  Little Flashcards
//
//  Created by Kilo Loco on 2/17/23.
//

import Amplify
import Foundation

protocol APIService {
    func getDecks() async throws -> [WireDeck]
    func createDeck(named name: String) async throws -> WireDeck
    func createCard(value: String, hexColor: String, deckId: String) async throws -> WireCard
}

struct AmplifyService: APIService {
    func createCard(value: String, hexColor: String, deckId: String) async throws -> WireCard {
        let card = WireCard(value: value, hexColor: hexColor, wiredeckID: deckId)
        let result = try await Amplify.API.mutate(request: .create(card))
        switch result {
        case .success(let newCard):
            return newCard
        case .failure(let error):
            throw error
        }
    }
    
    func getDecks() async throws -> [WireDeck] {
        let result = try await Amplify.API.query(request: .list(WireDeck.self))
        switch result {
        case .success(let decks):
            return Array(decks)
        case .failure(let error):
            throw error
        }
    }
    
    func createDeck(named name: String) async throws -> WireDeck {
        let deck = WireDeck(name: name)
        let result = try await Amplify.API.mutate(request: .create(deck))
        switch result {
        case .success(let newDeck):
            return newDeck
        case .failure(let error):
            throw error
        }
    }
}
