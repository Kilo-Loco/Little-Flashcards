//
//  CreateFlashcardView.swift
//  Little Flashcards
//
//  Created by Kilo Loco on 2/18/23.
//

import SwiftUI

struct CreateFlashcardView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ViewModel
    
    init(deck: WireDeck) {
        self._viewModel = .init(wrappedValue: ViewModel(deck: deck))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Card value", text: $viewModel.flashcardValue)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                ColorPicker("Card Color", selection: $viewModel.cardColor)
                Button("Create Card") {
                    viewModel.createFlashcard {
                        self.dismiss.callAsFunction()
                    }
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("New Flashcard")
        }
    }
}

extension CreateFlashcardView {
    class ViewModel: ObservableObject {
        @Published var flashcardValue: String = ""
        @Published var cardColor: Color = .gray
        
        let apiService: APIService = AmplifyService()
        let deck: WireDeck
        
        init(deck: WireDeck) {
            self.deck = deck
        }
        
        func createFlashcard(onComplete callback: @escaping () -> Void) {
            Task {
                do {
                    let card = try await apiService.createCard(
                        value: flashcardValue,
                        hexColor: cardColor.toHex() ?? "#ffffff",
                        deckId: deck.id
                    )
                    print("saved \(card.value)")
                    await MainActor.run {
                        callback()
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct CreateFlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFlashcardView(deck: .init(name: ""))
    }
}
