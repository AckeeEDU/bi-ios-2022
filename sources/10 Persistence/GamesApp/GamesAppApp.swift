//
//  GamesAppApp.swift
//  GamesApp
//
//  Created by Igor Rosocha on 30.11.2022.
//

import SwiftUI

@main
struct GamesAppApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView(keyName: "title", letter: "S")
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
