//
//  AddNewGameView.swift
//  GamesApp
//
//  Created by Igor Rosocha on 30.11.2022.
//

import SwiftUI

/// View which represents form to add a new game
struct AddNewGameView: View {
    
    // MARK: - Private properites
    
    /// Game genres
    private let genres = ["Sandbox", "MMORPG", "Simulator", "Sports"]
    
    @State private var title = ""
    @State private var genre = "Sandbox"
    @State private var review = ""
    @State private var rating = 3
    
    /// Core Data managed object
    @Environment(\.managedObjectContext) private var moc
    
    /// Dismiss
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - UI
    
    var body: some View {
        NavigationView {
            Form {
                Section("Basic information") {
                    TextField(
                        "Name of the game",
                        text: $title
                    )
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("My review") {
                    TextEditor(text: $review)
                    
                    Picker("Rating", selection: $rating) {
                        ForEach(0..<6) {
                            Text(String($0))
                        }
                    }
                }
                
                Section {
                    Button("Save") {
                        // Add a new game
                        let game = CoreDataGame(context: moc)
                        game.id = UUID().uuidString
                        game.title = title
                        game.rating = Int16(rating)
                        game.genre = genre
                        game.review = review
                        
                        do {
                            try moc.save()
                        } catch {
                            print("ERROR SAVING TO CORE DATA:", error.localizedDescription)
                        }
                        
                        dismiss()
                    }
                }
            }
            
        }
        .navigationTitle("Add Game")
    }
    
    // MARK: - Private helpers
    
    private func saveToFileSystem(games: [Game]) {
        let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first
        let url = documentDirectory?.appendingPathExtension(GamesSave.url)
        let data = try? JSONEncoder().encode(games)
        
        if let url = url, let data = data {
            do {
                try data.write(to: url)
            } catch {
                print("GAMES SAVE ERROR:", error.localizedDescription)
            }
        }
    }
    
    private func storeInUserDefaults(games: [Game]) {
        UserDefaults.standard.set(
            try? JSONEncoder().encode(games),
            forKey: GamesSave.userDefaultsKey
        )
    }
}

// MARK: - Previews

struct AddNewGameView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGameView()
    }
}
