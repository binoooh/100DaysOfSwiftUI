//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Vinz on 6/3/25.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
