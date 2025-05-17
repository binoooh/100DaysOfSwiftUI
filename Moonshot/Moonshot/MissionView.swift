//
//  MissionView.swift
//  Moonshot
//
//  Created by @binoooh on 5/17/25.
//

import SwiftUI

struct MissionView: View {
    
    // Nested struct for crew members data
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    // Get an instance of our Mission struct
    let mission: Mission
    
    // Property to save CrewMember array
    let crew: [CrewMember]
    
    var body: some View {
        
        // Create a horizontal scrolling view
        ScrollView {
            VStack { // Main VStack
                Image(mission.image) // Show the mission logo
                    .resizable()
                    .scaledToFit()
                    // Set the image to 50-60% width off the frame
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                
                VStack(alignment: .leading) { // View placeholder for the mission description
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightMode)
                        .padding(.vertical)
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightMode)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                // Create a horizontal scroll view to display crew members
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        // Loop through the crew property with each role
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink {
                                AstronautView(astronaut: crewMember.astronaut)
                            } label: {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                        .overlay(
                                            Capsule()
                                                .stroke(.white, lineWidth: 1)
                                        )
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkMode)
    }
    
    // Custom initializer that accepts the mission and all its astronauts
    init(mission: Mission, astronauts: [String: Astronaut]) {
        // Set the mission
        self.mission = mission
        // Find the astronauts for the specific mission
        self.crew = mission.crew.map { member in
            // If we find matching astronauts return the CrewMember struct
            // else throw fatal error
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
