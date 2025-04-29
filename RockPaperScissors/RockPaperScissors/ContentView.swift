//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by @binoooh on 4/27/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moves: [String] = ["✊", "✋", "✌️"].shuffled()
    
    @State private var playerScore = 0
    @State private var gameScore = 0
    @State private var score = 0
    
    @State private var playerChoice = ""
    @State private var gameChoice = ""
    @State private var result = ""
    
    @State private var showGameOver = false
    @State private var showPlayerChoice = false
    @State private var showWinner = false
    @State private var showFinalScore = false
    
    @State private var shouldWin = Bool.random()
    @State private var playerPick = Int.random(in: 0...2)
    @State private var gamePick = Int.random(in: 0...2)
    
    @State private var currentRound = 1
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(
                gradient: Gradient(
                    colors: [.blue, .red]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                
                Text("Rock Paper Scissor")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .padding()
                
                Button {
                    playGame()
                } label: {
                    Text(moves[playerPick])
                        .font(.system(size: 150))
                }
                .padding()
                .background(.white)
                .clipShape(.circle)
                
                Text("Round: \(currentRound)/10")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Text("Score: \(playerScore)")
                    .padding(.top, -10)
                    .font(.title)
                    .foregroundStyle(.white)
    
            }
            .padding()
            
            if showPlayerChoice {
                
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity) // Fade in/out
                    .onTapGesture {
                        // Optional: Dismiss on background tap
                        //withAnimation {
                        //    showPlayerChoice = false
                        //}
                    }
                CustomAlertView(
                    isPresented: $showPlayerChoice, // Pass the binding
                    title: "You Played",
                    message: "\(playerChoice)",
                    buttonTitle: "See Who Wins?",
                    // Optional: Custom size and color
                    messageSize: 60,
                    width: 320,
                    height: 200,
                    backgroundColor: Color(.white),
                    action: {
                        checkWinner()
                    }
                )
            }
            
            if showWinner {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity) // Fade in/out
                    .onTapGesture {}
                CustomAlertView(
                    isPresented: $showWinner, // Pass the binding
                    title: "\(result)",
                    message: "Game Played: \(gameChoice)",
                    buttonTitle: "Play Again?",
                    // Optional: Custom size and color
                    messageSize: 25,
                    width: 320,
                    height: 200,
                    backgroundColor: Color(.white),
                    action: {
                        playAgain()
                    }
                )
            }
            
            if showGameOver {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity) // Fade in/out
                    .onTapGesture {}
                CustomAlertView(
                    isPresented: $showGameOver, // Pass the binding
                    title: "Game Over!",
                    message: "Your Score: \(playerScore)",
                    buttonTitle: "Play Again?",
                    // Optional: Custom size and color
                    messageSize: 20,
                    width: 320,
                    height: 200,
                    backgroundColor: Color(.white),
                    action: {
                        resetGame()
                    }
                )
            }
        }
    }
    
    func playAgain() {
       
        if currentRound == 10 {
            showGameOver = true
        } else {
            currentRound += 1
            shouldWin = Bool.random()
            playerPick = Int.random(in: 0...2)
            gamePick = Int.random(in: 0...2)
            playerChoice = moves[playerPick]
            gameChoice = moves[gamePick]
        }
        
    }
    
    func resetGame() {
        currentRound = 1
        playerScore = 0
        gameScore = 0
        shouldWin = Bool.random()
        playerPick = Int.random(in: 0...2)
        gamePick = Int.random(in: 0...2)
        playerChoice = ""
        gameChoice = ""
    }
    
    func playGame() {
        playerChoice = moves[playerPick]
        gameChoice = moves[gamePick]
        showPlayerChoice = true
    }
    
    func checkWinner() {
        
        let winningMoves = [1, 2, 0] // paper, scissor, rock
        let didWin: Bool
        
        if shouldWin {
            didWin = playerPick == winningMoves[gamePick]
        } else {
            didWin = gamePick == winningMoves[playerPick]
        }
        
        if playerPick == gamePick {
            result = "Draw"
        } else {
            result = didWin ? "You Win!" : "You Lose!"
        }
        // TODO: Fix game scoring logic
        playerScore = result == "Draw" ? playerScore : result == "You Win!" ? playerScore + 1 : playerScore - 1
//        gameScore = result == "Draw" ? gameScore : result == "You Loose!" ? gameScore + 1 : gameScore - 1
        
        // to avoid negative score
        playerScore = playerScore < 0 ? 0 : playerScore
//        gameScore = gameScore < 0 ? 0 : gameScore
        
        showWinner = true
    }
    
}

#Preview {
    ContentView()
}
