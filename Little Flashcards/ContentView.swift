//
//  ContentView.swift
//  Little Flashcards
//
//  Created by Kilo Loco on 2/14/23.
//

import SwiftUI

struct CardView: View {
    let content: String
    let color: Color
    
    init(card: any Card) {
        self.content = card.value
        self.color = Color(hex: card.hexColor)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width - 100
            let height = width * (2/3)
            VStack {
                Text(content)
                    .foregroundColor(.black)
                    .font(.system(size: 100))
                    .frame(maxWidth: width, maxHeight: height)
                    .background(color)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    func toHex() -> String? {
            let uic = UIColor(self)
            guard let components = uic.cgColor.components, components.count >= 3 else {
                return nil
            }
            let r = Float(components[0])
            let g = Float(components[1])
            let b = Float(components[2])
            var a = Float(1.0)

            if components.count >= 4 {
                a = Float(components[3])
            }

            if a != Float(1.0) {
                return "#" + String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
            } else {
                return "#" + String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
            }
        }
}

protocol Card: Identifiable {
    var id: String { get }
    var value: String { get }
    var detail: String? { get }
    var hexColor: String { get }
}

struct NumberCard: Card {
    let value: String
    let detail: String? = nil
    let hexColor: String = "#93c47d"
    
    init(_ value: Int) {
        self.value = String(value)
    }
}

extension NumberCard {
    var id: String {
        value + hexColor
    }
}

struct HFWCard: Card {
    let value: String
    let detail: String? = nil
    let hexColor: String = "#ea9999"
    
    var id: String {
        value + hexColor
    }
}

struct LetterCard: Card {
    let value: String
    let detail: String? = nil
    let hexColor: String = "#ffd966"
    
    var id: String {
        value + hexColor
    }
}

struct WordCard: Card {
    let value: String
    let detail: String? = nil
    let hexColor: String = "#6fa8dc"
    
    var id: String {
        value + hexColor
    }
}

protocol Deck {
    associatedtype CardType
    
    var cards: [CardType] { get }
}

struct NumbersDeck: Deck {
    let cards: [NumberCard] = Array(1...30).map(NumberCard.init)
}

struct HFWDeck: Deck {
    let cards: [HFWCard] = [
        "was", "with", "in", "his", "and",
        "to", "it", "you", "of", "he",
        "for", "are", "they", "at", "as",
        "the", "on", "a", "is", "that"
    ].map(HFWCard.init)
}

struct LetterDeck: Deck {
    let cards: [LetterCard] = [
        "a", "b", "c", "d", "e",
        "f", "g", "h", "i", "j",
        "k", "l", "m", "n", "o",
        "p", "q", "r", "s", "t",
        "u", "v", "w", "x", "y",
        "z"
    ].map(LetterCard.init)
}

struct WordDeck: Deck {
    let cards: [WordCard] = [
        "map", "cap", "net", "log", "bag",
        "mad", "tag", "jam", "ham", "pan",
        "can", "van", "cat", "mat", "sat",
        "rat", "bed", "peg", "leg", "hen",
        "pen", "ten", "pig", "sit", "pit",
        "six", "mix", "dog", "top", "pot",
        "lot", "box", "fox", "rug", "sun",
        "run", "bus", "nut", "cut", "sad",
        "men", "pin", "bun", "tap", "red",
        "fin", "set", "cob", "mop"
    ].map(WordCard.init)
}

struct ContentView: View {
    
    let numbersDeck = NumbersDeck()
    let hfwDeck = HFWDeck()
    let letterDeck = LetterDeck()
    let wordDeck = WordDeck()
    
    var body: some View {
        TabView {
            ForEach(wordDeck.cards.shuffled()) { card in
                CardView(card: card)
            }
        }
        .tabViewStyle(.page)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
