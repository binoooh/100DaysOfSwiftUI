//
//  ScenePhaseSample.swift
//  Flashzilla
//
//  Created by bino on 7/4/25.
//

import SwiftUI

struct ScenePhaseSample: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text("Hello, world!")
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

#Preview {
    ScenePhaseSample()
}
