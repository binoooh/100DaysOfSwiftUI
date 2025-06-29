//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by bino on 6/28/25.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
