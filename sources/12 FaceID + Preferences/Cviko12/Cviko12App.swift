//
//  Cviko12App.swift
//  Cviko12
//
//  Created by Lukáš Hromadník on 14.12.2022.
//

import SwiftUI

@main
struct Cviko12App: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                AuthenticationView()
                    .tabItem {
                        Label("Authenticatoion", systemImage: "faceid")
                    }

                TableView()
                    .tabItem {
                        Label("Preferences", systemImage: "square.grid.3x2")
                    }
            }
        }
    }
}
