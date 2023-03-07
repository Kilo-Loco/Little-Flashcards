//
//  Navigator.swift
//  Little Flashcards
//
//  Created by Kilo Loco on 2/18/23.
//

import SwiftUI

extension WireDeck: Hashable {
    public static func ==(_ lhs: WireDeck, _ rhs: WireDeck) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.id 
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

enum Route: Hashable {
    case deck(_ deck: WireDeck)
}

class Navigator: ObservableObject {
    @Published var routes: [Route] = []
    
    func go(to route: Route) {
        print(route)
        routes.append(route)
    }
}


