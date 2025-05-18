//
//  GridLayoutView.swift
//  Moonshot
//
//  Created by @binoooh on 5/18/25.
//

// Day 41 Coding Challenge

import SwiftUI

struct GridLayoutView: View {
    
    let astronauts: [String: Astronaut]
    let missons: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
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
    }
}

#Preview {
    GridLayoutView(astronauts: Bundle.main.decode("astronauts.json"), missons: Bundle.main.decode("missions.json"))
}
