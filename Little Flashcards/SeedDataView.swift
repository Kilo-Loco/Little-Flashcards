//
//  SeedDataView.swift
//  Little Flashcards
//
//  Created by Kilo Loco on 2/15/23.
//

import Amplify
import SwiftUI

struct SeedDataView: View {
    var body: some View {
        Button("Seed Numbers", action: seedData)
    }
    
    func seedData() {
        let letterDeck = WireDeck(name: "LetterDeck Deck")
        let hfwDeck = WireDeck(name: "HFW Deck")
        let wordDeck = WireDeck(name: "Word Deck")
        
        Task {
            do {
                let letterDeckResult = try await Amplify.API.mutate(request: .create(letterDeck))
                print(letterDeckResult)
                let hfwDeckResult = try await Amplify.API.mutate(request: .create(hfwDeck))
                print(hfwDeckResult)
                let wordDeckResult = try await Amplify.API.mutate(request: .create(wordDeck))
                print(wordDeckResult)
                
                print("START LETTER DECK")
                for card in LetterDeck().cards {
                    let wireCard = WireCard(value: card.value, hexColor: card.hexColor, wiredeckID: letterDeck.id)
                    let result = try await Amplify.API.mutate(request: .create(wireCard))
                    print("letter card result:", result)
                }
                
                print("START HFW DECK")
                for card in HFWDeck().cards {
                    let wireCard = WireCard(value: card.value, hexColor: card.hexColor, wiredeckID: hfwDeck.id)
                    let result = try await Amplify.API.mutate(request: .create(wireCard))
                    print("hfw card result:", result)
                }
                
                print("START WORD DECK")
                for card in WordDeck().cards {
                    let wireCard = WireCard(value: card.value, hexColor: card.hexColor, wiredeckID: wordDeck.id)
                    let result = try await Amplify.API.mutate(request: .create(wireCard))
                    print("word card result:", result)
                }
                
            } catch {
                print(error)
            }
        }
    }
}

struct SeedDataView_Previews: PreviewProvider {
    static var previews: some View {
        SeedDataView()
    }
}
