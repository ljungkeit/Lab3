//
//  GameHub.swift
//  Lab3
//
//  Created by Rayan Adam Charah on 3/4/26.
//
import SwiftUI
import Foundation

@Observable
class GameHub {
    var games: [Game] = []
    
    func borrowGame(game: Game)
    {
        if let index = games.firstIndex(where: { $0.id == game.id})
        {
            games[index].available = false
        }
    }
    func returnGame(game: Game)
    {
        if let index = games.firstIndex(where: { $0.id == game.id})
        {
            games[index].available = true
        }
    }
        
}
