//
//  MissionDetailsView.swift
//  Moonshot
//
//  Created by @binoooh on 5/18/25.
//

// Day 43 Coding Challenge

import SwiftUI

struct MissionDetailsView: View {
    
    // Get an instance of our Mission struct
    let mission: Mission
    
    var body: some View {
        Image(mission.image) // Show the mission logo
            .resizable()
            .scaledToFit()
            // Set the image to 50-60% width off the frame
            .containerRelativeFrame(.horizontal) { width, axis in
                width * 0.6
            }
            .padding(.top)
        // Day 41 Coding Challenge
        Text("Launch Date: \(mission.formattedLaunchDate)")
            .font(.headline)
            .padding()
        
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
    }
}

#Preview {
    MissionDetailsView(mission: Bundle.main.decode("missions.json"))
        .preferredColorScheme(.dark)
}
