//
//  Planet.swift
//  Planets
//
//  Created by @binoooh on 5/19/25.
//

import Foundation

struct Planet: Codable, Identifiable {
    
    struct Moons: Codable {
        let name: String
    }
    
    let id: String
    let name: String
    let description: String
    let image: String
    let moons: [Moons]?
    
}
