//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Vinz on 6/11/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
