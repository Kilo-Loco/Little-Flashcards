//
//  CreateDeckView.swift
//  Little Flashcards
//
//  Created by Kilo Loco on 2/18/23.
//

import SwiftUI

struct CreateDeckView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Deck name", text: $viewModel.deckName)
                    .textFieldStyle(.roundedBorder)
                Button("Create Deck") {
                    viewModel.createDeck {
                        self.dismiss.callAsFunction()
                    }
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("New Deck")
        }
    }
}

extension CreateDeckView {
    class ViewModel: ObservableObject {
        @Published var deckName: String = ""
        
        let apiService: APIService = AmplifyService()
        
        func createDeck(onComplete callback: @escaping () -> Void) {
            Task {
                do {
                    let deck = try await apiService.createDeck(named: deckName)
                    print("Created \(deck.name)")
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

struct CreateDeckView_Previews: PreviewProvider {
    static var previews: some View {
        CreateDeckView()
    }
}
