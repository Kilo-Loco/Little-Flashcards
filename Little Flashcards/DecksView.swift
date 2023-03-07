//
//  DecksView.swift
//  Little Flashcards
//
//  Created by Kilo Loco on 2/17/23.
//

import SwiftUI

extension WireDeck: Identifiable {}

struct DecksView: View {
    @StateObject var navigator: Navigator = .init()
    @StateObject var viewModel: ViewModel = .init()
    
    @State var routes: [Route] = []
    
    var body: some View {
        NavigationStack(path: $navigator.routes) {
            ActionButton(imageName: "plus") {
                viewModel.isCreateDeckSheetVisible.toggle()
            } content: {
                List(viewModel.decks) { deck in
                    NavigationLink(deck.name) {
                        FlashcardsView(deck: deck)
                            .navigationTitle(deck.name)
                    }
                }
            }
            .navigationTitle("Decks")
            .onAppear(perform: viewModel.getDecks)
            .sheet(isPresented: $viewModel.isCreateDeckSheetVisible) {
                CreateDeckView()
            }
        }
    }
}

extension DecksView {
    class ViewModel: ObservableObject {
        @Published var decks: [WireDeck] = []
        @Published var isCreateDeckSheetVisible = false
        
        let apiService: APIService = AmplifyService()
        
        func getDecks() {
            Task {
                do {
                    let decks = try await apiService.getDecks()
                    await MainActor.run {
                        self.decks = decks
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct DecksView_Previews: PreviewProvider {
    static var previews: some View {
        DecksView()
    }
}
