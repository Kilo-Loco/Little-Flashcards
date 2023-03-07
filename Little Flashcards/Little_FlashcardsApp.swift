//
//  Little_FlashcardsApp.swift
//  Little Flashcards
//
//  Created by Kilo Loco on 2/14/23.
//

import Amplify
import AWSAPIPlugin
import SwiftUI

@main
struct Little_FlashcardsApp: App {
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            DecksView()
        }
    }
    
    private func configureAmplify() {
//        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
        
        do {
//            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.add(plugin: apiPlugin)
            try Amplify.configure()
            print("Initialized Amplify")
        } catch {
            print("Could not initialize Amplify: \(error)")
        }
    }
}
