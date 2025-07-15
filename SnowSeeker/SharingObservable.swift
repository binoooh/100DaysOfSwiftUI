//
//  SharingObservable.swift
//  SnowSeeker
//
//  Created by bino on 7/13/25.
//

import SwiftUI

@Observable
class Player {
    var name = "Anonymous"
    var highScore = 0
}

struct HighScoreView: View {
    //var player: Player
    @Environment(Player.self) var player
//    @Bindable var player = player

    var body: some View {
        Text("Your high score: \(player.highScore)")
    }
}

struct SharingObservable: View {
    
    @State private var player = Player()
    
    var body: some View {
        VStack {
            Text("Welcome!")
            HighScoreView()
        }
        .environment(player)
    }
}

#Preview {
    SharingObservable()
}
