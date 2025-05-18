//
//  ContentView.swift
//  Moonshot
//
//  Created by @binoooh on 5/15/25.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missons: [Mission] = Bundle.main.decode("missions.json")
    
    // Day 41 Code Challenge
    @State private var showGrid = false
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
    
            NavigationStack {
                // Day 41 Code Challenge
                Group {
                    if showGrid {
                        GridLayoutView(astronauts: astronauts, missons: missons)
                    } else {
                        ListLayoutView(astronauts: astronauts, missons: missons)
                    }
                }
                // Day 41 Code Challenge
                .toolbar {
                    Button {
                        showGrid.toggle()
                    } label: {
                        Image(systemName: "grid")
                    }
                }
                .navigationTitle("Moonshot")
                .background(.darkMode)
                .preferredColorScheme(.dark)
            }
    }
}

#Preview {
    ContentView()
}
