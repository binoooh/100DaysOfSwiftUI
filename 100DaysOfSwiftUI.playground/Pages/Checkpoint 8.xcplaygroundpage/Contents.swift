//: [Previous](@previous)

import Foundation

protocol Building {
    var rooms: Int { get }
    var cost: Int { get set }
    var agent: String { get }
    
    func summary() -> String
}

extension Building {
    func summary() -> String {
        return """
      Details about the \(Self.self)
      - rooms: \(self.rooms)
      - cost: \(self.cost) dollars
      - agentName: \(self.agent)
      """
    }
}

struct House: Building {
    var rooms: Int
    var cost: Int
    var agent: String
}

struct Office: Building {
    var rooms: Int
    var cost: Int
    var agent: String
}

func printSummary(using building: Building) {
    print(building.summary())
}

let house = House(rooms: 3, cost: 500_000, agent: "Jane")
printSummary(using: house)

let office = Office(rooms: 20, cost: 100_000_000, agent: "Liam")
printSummary(using: office)

//: [Next](@next)
