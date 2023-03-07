//
//  RootView.swift
//  Little Flashcards
//
//  Created by Kilo Loco on 2/21/23.
//

import ComposableArchitecture
import SwiftUI

struct NavigationState: Equatable {
    var routes: [Route] = []
}

struct RootState: Equatable {
    var navigationState = NavigationState()
}

enum NavigationAction {
    case goTo(Route)
    case updatesRoutes([Route])
}

enum RootAction {
    case navigationAction(NavigationAction)
}

struct RootEnvironment { }

typealias RootStore = Store<RootState, RootAction>
typealias RootReducer = AnyReducer<RootState, RootAction, RootEnvironment>

struct RootFeature: ReducerProtocol {
    struct State {
        var navigationState = NavigationState()
    }
    
    enum Action {
        case navigationAction(NavigationAction)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .navigationAction(let navAction):
            switch navAction {
            case .goTo(let route):
                state.navigationState.routes.append(route)
                
            case .updatesRoutes(let routes):
                state.navigationState.routes = routes
            }
        }
    }
}

struct RootView: View {
    let store: RootStore
    
    var body: some View {
        WithViewStore(store.stateless) { _ in
            ContentView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: .init(initialState: .init(), reducer: <#T##ReducerProtocol#>))
    }
}
