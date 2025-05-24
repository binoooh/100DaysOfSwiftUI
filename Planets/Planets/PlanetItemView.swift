//
//  CardViewItem.swift
//  Planets
//
//  Created by @binoooh on 5/24/25.
//

import SwiftUI

struct PlanetItemView: View {
    
    let planet: Planet
    let allMoonsDictionary: [String: Moon]
    @Binding var isFullScreen: Bool // Use @Binding to modify ContentView's isFullScreen
    
    var body: some View {
        
        ZStack {
            CardsView(topColor: Color.black, midColor: Color.black, bottomColor: Color.white, isFullScreen: isFullScreen)
                .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                .scrollTransition { content, phase in
                    content
                        .opacity(phase.isIdentity ? 1.0 : 0.5)
                        .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3,
                                     y: phase.isIdentity ? 1.0 : 0.3)
                        .offset(y: phase.isIdentity ? 0 : 50)
                    
                }
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.3)) {
                        isFullScreen.toggle()
                        
                    }
                }
            ScrollView {
                VStack {
                    // 1. Resolve the full Moon objects for the current planet
                    let currentPlanetFullMoons: [Moon] = (planet.moons ?? []).compactMap { planetMoonNameEntry in
                        if planetMoonNameEntry.name == "None" { return nil }
                        // Find the Moon object by its display name from the allMoonsDictionary
                        return self.allMoonsDictionary.values.first { $0.name == planetMoonNameEntry.name }
                    }
                    
                    // 2. Transform [Moon] to [PlanetView.PlanetMoon]
                    let planetViewMoons: [PlanetView.PlanetMoon] = currentPlanetFullMoons.map { moonObject in
                        PlanetView.PlanetMoon(id: moonObject.id, moon: moonObject)
                    }
                    
                    // 3. Pass the correctly typed array to PlanetView
                    PlanetView(planet: planet)
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.5)
                                .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3,
                                             y: phase.isIdentity ? 1.0 : 0.3)
                                .offset(y: phase.isIdentity ? 0 : 50)
                            
                        }
                        .padding(.vertical, isFullScreen ? 50 : 0)
                    
                    Text(planet.name)
                        .font(.title.bold())
                        .fontDesign(.monospaced)
                        .foregroundStyle(isFullScreen ? .white : .black)
                        .shadow(radius: 20)
                        .padding(.bottom)
                    
                    Text(planet.description)
                        .font(.title2)
                        .textScale(.default)
                        .foregroundStyle(.white)
                        .frame(width: 300)
                        .padding(.top)
                    
                    Text("\(planet.name)'s Moon")
                        .font(.title2.bold())
                        .fontDesign(.monospaced)
                        .foregroundStyle(.white)
                        .padding(.all)
                    
                        HStack {
                            ForEach(planetViewMoons, id: \.id) { pvMoon in // Assuming PlanetView.PlanetMoon becomes Identifiable
                                MoonView(moon: pvMoon.moon)
                            }
                        }
                        .padding()
                }
           }
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.3)) {
                    isFullScreen.toggle()
                }
            }
            .frame(height: !isFullScreen ? UIScreen.main.bounds.height / 3 : .infinity)
            .scrollDisabled(true)
            .scrollIndicators(.hidden)
            
        }
    }
}
