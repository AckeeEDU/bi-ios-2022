//
//  ContentView.swift
//  GamesApp
//
//  Created by Igor Rosocha on 30.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Private properties
    
    /// State propery for presenting `AddNewGameView`
    @State private var showingAddScreen = false
    
    /// `CoreDataGame` results stored in Core Data
    @FetchRequest private var games: FetchedResults<CoreDataGame>
    
    /// Core Data managed object
    @Environment(\.managedObjectContext) private var moc
    
    /// Name of key to use for Core Data predicate
    private var keyName: String
    
    /// Letter to use for Core Data predicate
    private var letter: String
    
    // MARK: - Initializers
    
    init(keyName: String, letter: String) {
        self.keyName = keyName
        self.letter = letter
        
        // Initialize `games` ordered by `rating` and `title`,
        // filtered by `keyName` and `letter` specified in initializer
        _games = FetchRequest<CoreDataGame>(
            sortDescriptors: [
                SortDescriptor(\.rating, order: .reverse),
                SortDescriptor(\.title)
            ],
            predicate: NSPredicate(format: "%K BEGINSWITH %@", keyName, letter)
        )
    }
    
    // MARK: - UI
    
    var body: some View {
        NavigationView {
            List {
                ForEach(games) { game in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(game.title ?? "")
                                .fontWeight(.heavy)
                            
                            Text("Genre: \(game.genre ?? "")")
                                .fontWeight(.medium)
                        }
                        
                        Spacer()
                        
                        Text(String(game.rating))
                    }
                }
                .onDelete(perform: deleteCoreDataGames)
            }
            .navigationTitle("Games List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add a new game", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $showingAddScreen) {
            AddNewGameView()
        }
    }
    
    // MARK: - Private helpers
    
    private static func loadGamesFromFileSystem() -> [Game] {
        let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first
        let url = documentDirectory?.appendingPathExtension(GamesSave.url)
        
        guard let url = url else { return [] }
        
        do {
            let gamesData = try Data(contentsOf: url)
            
            do {
                let games = try JSONDecoder().decode([Game].self, from: gamesData)
                return games
            } catch {
                print("GAMES DECODING ERROR:", error.localizedDescription)
            }
        } catch {
            print("GAMES LOADING ERROR:", error.localizedDescription)
        }
        
        return []
    }
    
    private static func loadGamesFromUserDefaults() -> [Game] {
        guard
            let gamesData = UserDefaults.standard.data(forKey: GamesSave.userDefaultsKey)
        else { return [] }
        
        do {
            let games = try JSONDecoder().decode([Game].self, from: gamesData)
            return games
        } catch {
            print("GAMES DECODING ERROR:", error.localizedDescription)
        }
        
        return []
    }
    
    private func deleteCoreDataGames(at offsets: IndexSet) {
        for offset in offsets {
            let game = games[offset]
            moc.delete(game)
        }
        
        try? moc.save()
    }
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(keyName: "title", letter: "S")
    }
}
