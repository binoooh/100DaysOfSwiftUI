//
//  GameData.swift
//  Edutainment
//
//  Created by @binoooh on 5/7/25.
//

import Foundation

struct GameData: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var number: Int
    var image: String
}

struct Data {
    
    static let sampleData = GameData(name: "level-4",
                                     number: 4,
                                     image: "4.square.fill")
    static let gameData = [
        GameData(name: "level-1",
                 number: 1,
                 image: "1.square.fill"),
        
        GameData(name: "level-2",
                 number: 2,
                 image: "2.square.fill"),
        
        GameData(name: "level-3",
                 number: 3,
                 image: "3.square.fill"),
        
        GameData(name: "level-4",
                 number: 4,
                 image: "4.square.fill"),
        
        GameData(name: "level-5",
                 number: 5,
                 image: "5.square.fill"),
        
        GameData(name: "level-6",
                 number: 6,
                 image: "6.square.fill"),
        
        GameData(name: "level-7",
                 number: 7,
                 image: "7.square.fill"),
        
        GameData(name: "level-8",
                 number: 8,
                 image: "8.square.fill"),
        
        GameData(name: "level-9",
                 number: 9,
                 image: "9.square.fill"),
        
        GameData(name: "level-10",
                 number: 10,
                 image: "10.square.fill"),
        
        GameData(name: "level-11",
                 number: 11,
                 image: "11.square.fill"),
        
        GameData(name: "level-12",
                 number: 12,
                 image: "12.square.fill")
    ]
}
