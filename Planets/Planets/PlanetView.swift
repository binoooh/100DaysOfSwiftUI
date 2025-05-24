//
//  PlanetView.swift
//  Planets
//
//  Created by @binoooh on 5/22/25.
//

import SwiftUI

struct PlanetView: View {
    
    struct PlanetMoon: Identifiable {
        let id: String
        let moon: Moon
    }
    
    let planet: Planet
    
    var body: some View {
        
        VStack {
            Image(planet.image)
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250)
        }
    }
}

#Preview {
    let planets: [Planet] = Bundle.main.decode("planets.json")
    PlanetView(planet: planets[0])
}
