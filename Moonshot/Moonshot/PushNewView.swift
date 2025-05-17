//
//  PushNewView.swift
//  Moonshot
//
//  Created by @binoooh on 5/15/25.
//

//  Topics:
//  1.Pushing view into a stack using NavigationStack & NavigationLink

import SwiftUI

struct PushNewView: View {
    var body: some View {
        VStack {
            NavigationStack {
                NavigationLink {
                    Text("Detail View")
                } label: {
                    VStack {
                        Text("Tap Me")
                        Image(systemName: "face.smiling")
                    }
                }
                .navigationTitle("Test View")
            }
            NavigationStack {
                List(0..<100) { row in
                    NavigationLink("Row: \(row)") {
                        Text("Detail Row: \(row)")
                    }
                }
                
            }
        }
        
    }
}

#Preview {
    PushNewView()
}
