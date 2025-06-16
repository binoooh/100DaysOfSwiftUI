//
//  iExpenseApp.swift
//  iExpense
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
