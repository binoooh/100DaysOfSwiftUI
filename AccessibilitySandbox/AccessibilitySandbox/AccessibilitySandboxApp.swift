//
//  AccessibilitySandboxApp.swift
//  AccessibilitySandbox
//
//  Created by Vinz on 6/25/25.
//

import SwiftUI

@main
struct AccessibilitySandboxApp: App {
    private func loadRocketSimConnect() {
        #if DEBUG
        guard (Bundle(path: "/Applications/RocketSim.app/Contents/Frameworks/RocketSimConnectLinker.nocache.framework")?.load() == true) else {
            print("Failed to load linker framework")
            return
        }
        print("RocketSim Connect successfully linked")
        #endif
    }
    var body: some Scene {
        WindowGroup {
            VoiceOverView()
        }
    }
}
