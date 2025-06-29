//
//  SwipeActionsSample.swift
//  HotProspects
//
//  Created by bino on 6/28/25.
//

import SwiftUI

struct SwipeActionsSample: View {
    var body: some View {
        List {
            Text("Swipe Me")
                .swipeActions {
                    Button("Send Message", systemImage: "message") {
                        print("I got swiped!!")
                    }
                }
                .tint(.blue)
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pinning!")
                    }
                }
                .tint(.orange)
        }
    }
}

#Preview {
    SwipeActionsSample()
}
