//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by @binoooh on 4/24/25.
//

import SwiftUI

// Project 3 - Challenge 2
struct FlagImage: View {
    var imageName: String
    //var width: CGFloat
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(style: StrokeStyle(lineWidth: 3)))
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    // countries array contains the name of the images on the Assets folder
    // we randomnize the array using shuffled() method
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    // correctAnswer automatically picks a random number
    @State private var correctAnswer = Int.random(in: 0...2)
    
    // scoreTitle stores the title that will be shown inside the alert
    @State private var scoreTitle = ""
    
    // showingScore store whether the alert is showing or not
    @State private var showingScore = false
    
    // showFinalScore is true if gamesPlayed = 8
    @State private var showFinalScore = false
    
    // playerScore store the user's score
    @State private var playerScore = 0
    
    // gamesPlaed store the number of games played
    @State private var gamesPlayed = 0
    
    // Day 34 - Challenge
    @State private var rotationAmount = 0
    @State private var opacityAmount = 1.0
    @State private var animationAmount = 1.0
    @State private var selectedFlag = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .red], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    // Create a loop to show 3 flags
                    ForEach(0..<3) { number in
                        Button {
                            selectedFlag = countries[number]
                            flagTapped(number)
                            // Day 34 - Challenge
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                rotationAmount += 360
                                opacityAmount -= 0.75
                                animationAmount = 0
                            }
                        } label: {
                            // Project 3 - Challenge 2
                            FlagImage(imageName: countries[number])
                                // Day 34 - Challenge
                                .rotation3DEffect(.degrees(Double(selectedFlag == countries[number] ? rotationAmount : 0)), axis: (x: 0, y: 1, z: 0))
                                .opacity(selectedFlag == countries[number] ? 1.0 : opacityAmount)
                                //.scaleEffect(selectedFlag == countries[number] ? 1.0 : animationAmount)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(playerScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            
        }
        
        // Show the alert and ask another question
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(playerScore)")
        }
        
        // Show final score and reset the game
        .alert(scoreTitle, isPresented: $showFinalScore) {
            Button("Restart the Game", action: resetGame)
        } message: {
            Text("Your final score is \(playerScore)")
        }
        
    }
    
    // Method to show the alert whether the answer is correct or wrong
    func flagTapped(_ number: Int) {
        
        // Increment gamesPlayed by 1
        gamesPlayed += 1
        
        if number == correctAnswer {
            scoreTitle = "Correct!"
            playerScore += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        if gamesPlayed < 8 {
            // add delay before showing the alert
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                showingScore = true
            }
        } else {
            scoreTitle = "Game Over!"
            // add delay before showing the alert
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                showFinalScore = true
            }
        }
        
    }
    
    // method to reset the game
    func resetGame() {
        gamesPlayed = 0
        playerScore = 0
        showingScore = false
        showFinalScore = false
        askQuestion()
    }
    
    func askQuestion() {
        // We reset the game by reshuffling the countries array
        // and pick random numbers from 0 - 2 assign it to correctAnswer
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        // Day 34 - Challenge
        opacityAmount = 1.0
        animationAmount = 1.0
        rotationAmount = 0
    }
}

#Preview {
    ContentView()
}
