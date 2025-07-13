//
//  DiceRollerApp.swift
//  DiceRoller
//
//  Created by bino on 7/13/25.
//

import SwiftUI

@main
struct DiceRollerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Configure SwiftData for the DiceRoll model.
        // This makes the model available throughout the app's views.
        .modelContainer(for: DiceRoll.self)
    }
}
