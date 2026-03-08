import SwiftUI

struct ContentView: View {
    @State private var gameHub = GameHub()
    @State private var showingAddGame = false
    @State private var newGameName = ""
    @State private var newGameCategory = ""
    @State private var searchText = ""

    // filters games based on search text
    var filteredGames: [Game] {
        if searchText.isEmpty {
            return gameHub.games
        } else {
            return gameHub.games.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredGames) { game in
                    HStack (spacing: 50) {
                        VStack(alignment: .leading) {
                            Text(game.name)
                                .font(.headline)
                                .padding(5)
                            Text(game.category)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(5)
                        }
                            Text(game.available ? "Available" : "Borrowed")
                            .foregroundColor(Color.green)
                            Button(game.available ? "Borrow" : "Return") {
                                if game.available {
                                    gameHub.borrowGame(game: game)
                                    Text("Borrowed")
                                } else {
                                    gameHub.returnGame(game: game)
                                }
                        }
                    }
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
                    TextField("Game Name", text: $newGameName)
                        .padding(10)
                    TextField("Category", text: $newGameCategory)
                    HStack {
                        Button("Cancel") {
                            showingAddGame = false
                        }
                        .padding(5)
                        Button("Add") {
                            gameHub.games.append(Game(name: newGameName, category: newGameCategory))
                            newGameName = ""
                            newGameCategory = ""
                            showingAddGame = false
                        }
                        .disabled(newGameName.isEmpty || newGameCategory.isEmpty)
                        .padding(5)
                    }
                }
            }
        }
    }
}
