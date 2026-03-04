//
//  GameHub.swift
//  Lab3
//
//  Created by Rayan Adam Charah on 3/4/26.
//
import SwiftUI

@Observable
class GameHub {
    
    
    var games: [Game] = []
    
    struct GameList: View {
        let games: [Game]

        var body: some View {
            List {
                ForEach(games) { game in
                    Text(game.name)
                }
            }
        }
    }
}
