import SwiftUI

struct ContentView: View {
    @State private var gameHub = GameHub()
    @State private var showingAddGame = false
    @State private var newGameName = ""
    @State private var newGameCategory: GameCategory = .action
    @State private var searchText = ""
    @State private var selectedCategoryFilter: GameCategory? = nil
    @State private var newGamePlayers: String = ""
    // filters games based on search text
    var filteredGames: [Game] {
        var results = gameHub.games
        
        if let selectedCategory = selectedCategoryFilter {
            results = results.filter { game in game.category == selectedCategory }
        }
        
        if !searchText.isEmpty {
            results = results.filter { game in game.name.localizedCaseInsensitiveContains(searchText) }
        }
        return results
    }
    
    struct GameRowView: View {
        let game: Game
        @Binding var gameHub: GameHub
        
        var body: some View {
            HStack(spacing: 50) {
                VStack(alignment: .leading) {
                    Text(game.name)
                        .font(.headline)
                        .padding(5)
                    Text(game.category.rawValue)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(5)
                    Text(game.numberOfPlayers + " players")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(5)
                }
                Text(game.available ? "Available" : "Borrowed")
                    .foregroundColor(game.available ? .green : .red)
                Button(game.available ? "Borrow" : "Return") {
                    if game.available {
                        gameHub.borrowGame(game: game)
                    } else {
                        gameHub.returnGame(game: game)
                    }
                }
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Text("Filter by:")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Picker("Category", selection: $selectedCategoryFilter) {
                        Text("All Categories")
                            .tag(GameCategory?.none)
                        
                        ForEach(GameCategory.allCases) { category in
                            Text(category.rawValue)
                                .tag(GameCategory?.some(category))
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(5)
                    Spacer()
                }
                .padding(.horizontal)
            }
            List {
                ForEach(filteredGames) { game in
                    GameRowView(game: game, gameHub: $gameHub)
                }
            }
            .searchable(text: $searchText, prompt: "Search games")
            .navigationTitle("Game Library")
            .toolbar {
                Button("Add Game") {
                    showingAddGame = true
                }
            }
            .sheet(isPresented: $showingAddGame) {
                Form {
                    Section("Game Info") {
                        TextField("Game Name", text: $newGameName)
                            .padding(10)
                    }
                    
                    Section("Select Category") {
                        ForEach(GameCategory.allCases) {category in
                            Button {
                                newGameCategory = category
                            } label :{
                                HStack {
                                    Text(category.rawValue)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    if newGameCategory == category {
                                        Image(systemName : "checkmark.circle.fill")
                                            .foregroundColor(.blue)
                                        
                                    } else {
                                        Image(systemName: "circle")
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                    Section {
                        HStack {
                            TextField("Number of Players", text: $newGamePlayers)
                        }
                    }
                    Section {
                        HStack {
                            Button("Cancel") {
                                showingAddGame = false
                                newGamePlayers = ""
                                newGameName = ""
                            }
                            .padding(5)
                            Button("Add") {
                                gameHub.games.append(Game(name: newGameName, category: newGameCategory, numberOfPlayers: newGamePlayers))
                                newGameName = ""
                                newGameCategory = .action
                                showingAddGame = false
                            }
                            .disabled(newGameName.isEmpty)
                            .padding(5)
                        }
                    }
                }
            }
        }
    }
}
