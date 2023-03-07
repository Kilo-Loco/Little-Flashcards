//
//  FlashcardsView.swift
//  Little Flashcards
//
//  Created by Kilo Loco on 2/18/23.
//

import SwiftUI

extension WireCard: Identifiable {}
extension WireCard: Card {}

struct FlashcardsView: View {
    @StateObject var viewModel: ViewModel
    
    let deck: WireDeck
    
    init(deck: WireDeck) {
        self.deck = deck
        self._viewModel = .init(wrappedValue: ViewModel(deck: deck))
    }
    
    var body: some View {
        ActionButton(imageName: "plus") {
            viewModel.isCreateFlashcardSheetVisible.toggle()
        } content: {
            TabView {
                ForEach(Array(viewModel.cards)) { card in
                    CardView(card: card)
                }
            }
            .tabViewStyle(.page)
        }
        .onAppear(perform: viewModel.getCards)
        .sheet(isPresented: $viewModel.isCreateFlashcardSheetVisible) {
            CreateFlashcardView(deck: deck)
        }
    }
}

extension FlashcardsView {
    class ViewModel: ObservableObject {
        @Published var cards: [WireCard] = []
        @Published var isCreateFlashcardSheetVisible: Bool = false
        
        private let deck: WireDeck
        
        init(deck: WireDeck) {
            self.deck = deck
        }
        
        func getCards() {
            Task {
                do {
                    try await deck.cards?.fetch()
                    guard let cards = deck.cards else { return }
                    await MainActor.run {
                        self.cards = Array(cards)
                        print(self.cards)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct FlashcardsView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardsView(deck: .init(name: "Test Deck"))
    }
}
