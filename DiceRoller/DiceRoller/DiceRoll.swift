//
//  DiceRoll.swift
//  DiceRoller
//
//  Created by bino on 7/13/25.
//

import Foundation
import SwiftData

// MARK: - Model for storing Dice Rolls
// This model defines the structure for a single dice roll entry.
// It conforms to Identifiable for use in ForEach and lists, and Codable for easy storage.
@Model
final class DiceRoll {
    var id: UUID // Unique identifier for each roll
    var date: Date // Timestamp of when the roll occurred
    var numberOfDice: Int // How many dice were rolled
    var diceType: Int // What type of dice (e.g., 4 for d4, 6 for d6)
    var totalResult: Int // The sum of all dice rolled

    init(id: UUID = UUID(), date: Date = Date(), numberOfDice: Int, diceType: Int, totalResult: Int) {
        self.id = id
        self.date = date
        self.numberOfDice = numberOfDice
        self.diceType = diceType
        self.totalResult = totalResult
    }
}
