//
//  Game.swift
//  Lab3
//
//  Created by Luca Thomas Jungkeit on 3/4/26.
//

class Game{
    var name: String;
    var available: Bool;
    var category: String;
    
    init (name: String, available: Bool , category: String){
        self.name = name
        self.category = category
        self.available = available
    }
}
