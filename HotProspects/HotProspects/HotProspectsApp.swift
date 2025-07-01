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
   
    init() {
        loadRocketSimConnect()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
    private func loadRocketSimConnect() {
        #if DEBUG
        guard (Bundle(path: "/Applications/RocketSim.app/Contents/Frameworks/RocketSimConnectLinker.nocache.framework")?.load() == true) else {
            print("Failed to load linker framework")
            return
        }
        print("RocketSim Connect successfully linked")
        #endif
    }
}
