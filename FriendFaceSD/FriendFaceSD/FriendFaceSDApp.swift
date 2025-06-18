//
//  FriendFaceSDApp.swift
//  FriendFaceSD
//
//  Created by Vinz on 6/17/25.
//

import SwiftUI
import SwiftData

@main
struct FriendFaceSDApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
