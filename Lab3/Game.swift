//
//  Game.swift
//  Lab3
//
//  Created by Luca Thomas Jungkeit on 3/4/26.
//

import Foundation // allows us to use UUID to create custom auto generated ID's for each game

struct Game: Identifiable {
    var id: UUID = UUID()
    var name: String
    var available: Bool = true
    var category: String;
}
