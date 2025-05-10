//
//  ContentView.swift
//  Edutainment
//
//  Created by @binoooh on 5/7/25.
//

import SwiftUI

struct Edutainment: View {
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @StateObject private var gameLevel = GameViewModel()
    
    var body: some View {
        
        ZStack {
            // Background gradient for the view.
            BackgroundGradientView()
            
            VStack(spacing: 20) {
                
                // Displays the header image.
                HeaderImageView()
                    .padding(.top, 40) // Adjusted padding for better spacing
                
                Section {
                    // View for displaying the grid of game levels.
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Data.gameData) { data in
                            LevelsImageView(gameData: data)
                                .onTapGesture {
                                    print("\(data.name)")
                                    gameLevel.selectedGameLevel = data
                                }
                        }
                    }
                }
                .padding(.top, 20)
                Spacer()
            }
            .padding(.all)
            // Show GameView with the selected game level in full screen
            .fullScreenCover(isPresented: $gameLevel.isShowingGameView) {
                // Safely unwrap selectedGameLevel.
                // If it's nil (which shouldn't happen if logic in ViewModel is correct),
                // a fallback view is shown.
                if let selectedLevel = gameLevel.selectedGameLevel {
                    GameView(gameData: selectedLevel)
                } else {
                    // Fallback view in case selectedGameLevel is unexpectedly nil.
                    // This helps prevent crashes and provides a user-friendly message.
                    VStack {
                        Text("Error")
                            .font(.largeTitle)
                        Text("No game level was selected. Please try again.")
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Dismiss") {
                            gameLevel.isShowingGameView = false // Allow dismissing the error
                        }
                        .padding()
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
    }
}

#Preview {
    Edutainment()
}
