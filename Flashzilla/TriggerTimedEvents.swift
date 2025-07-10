//
//  TriggerTimedEvents.swift
//  Flashzilla
//
//  Created by bino on 7/4/25.
//

import SwiftUI

struct TriggerTimedEvents: View {
    
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time now is \(time)")
                }
                counter += 1
            }
    }
}

#Preview {
    TriggerTimedEvents()
}
