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
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missons) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.lightMode)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightMode)
                            )
                            .padding()
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            
            .navigationBarTitle("Moonshot")
            .background(.darkMode)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
