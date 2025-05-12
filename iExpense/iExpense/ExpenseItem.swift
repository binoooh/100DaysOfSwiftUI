//
//  ExpenseItem.swift
//  iExpense
//
//  Created by @binoooh on 5/12/25.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
