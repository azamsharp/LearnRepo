//
//  LearnApp.swift
//  Learn
//
//  Created by Mohammad Azam on 7/14/22.
//

import SwiftUI

enum Route: Hashable {
    case detail(Tweet)
}

@main
struct LearnApp: App {
    
    var appState: AppState = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .detail(let tweet):
                                DetailView(tweet: tweet)
                        }
                    }
            }.environmentObject(appState)
        }
    }
}
