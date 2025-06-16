//
//  ExpenseItem.swift
//  iExpense
//
//  Created by @binoooh on 5/12/25.
//

import SwiftUI
import SwiftData

// Day 59 Coding Challenge
@Model
class ExpenseItem {
    //var id = UUID()
    var name: String
    var type: String
    var amount: Double
    var currency: String
    
    init(name: String, type: String, amount: Double, currency: String) {
        self.name = name
        self.type = type
        self.amount = amount
        self.currency = currency
    }
}
