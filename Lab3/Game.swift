//
//  Game.swift
//  Lab3
//
//  Created by Luca Thomas Jungkeit on 3/4/26.
//

import Foundation // allows us to use UUID to create custom auto generated ID's for each game
enum GameCategory: String, CaseIterable, Identifiable, Equatable {
    case action = "Action"
    case adventure = "Adventure"
    case puzzle = "Puzzle"
    case rpg = "RPG"
    case story = "Story"
    case shooter = "Shooter"
    
    var id: String { self.rawValue }
}
struct Game: Identifiable {
    var id: UUID = UUID()
    var name: String
    var available: Bool = true
    var category: GameCategory;
}
