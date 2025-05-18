//
//  ListLayoutView.swift
//  Moonshot
//
//  Created by @binoooh on 5/18/25.
//

// Day 41 Coding Challenge

import SwiftUI

struct ListLayoutView: View {
    
    let astronauts: [String: Astronaut]
    let missons: [Mission]
    
    var body: some View {
        ZStack {
            List {
                ForEach(missons) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                }
                //.padding([.horizontal, .bottom])
                .listStyle(.plain)
                .listRowBackground(Color.darkMode)
            }
            .scrollContentBackground(.hidden)
        }
        .background(Color.darkMode)
    }
}

#Preview {
    ListLayoutView(astronauts: Bundle.main.decode("astronauts.json"), missons: Bundle.main.decode("missions.json"))
}
