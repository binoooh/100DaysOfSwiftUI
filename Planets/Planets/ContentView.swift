import SwiftUI

struct ContentView: View {
    
    let planets: [Planet] = Bundle.main.decode("planets.json")
    let allMoonsDictionary: [String: Moon] = Bundle.main.decode("moons.json")
    
    @State private var isFullScreen = false
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(planets, id: \.id) { planet in
                    PlanetItemView(
                        planet: planet,
                        allMoonsDictionary: self.allMoonsDictionary,
                        isFullScreen: $isFullScreen
                    )
                }
            }
            .scrollTargetLayout()
        }
        .scrollDisabled(isFullScreen)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
        .preferredColorScheme(.dark)
    }
}
