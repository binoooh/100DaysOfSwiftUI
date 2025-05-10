//
//  GameView.swift
//  Edutainment
//
//  Created by @binoooh on 5/7/25.
//

import SwiftUI

struct GameView: View {
    
    var gameData: GameData
    
    // Multiplication options
    @State private var multipliers: [Int] = Array(1...12)
    
    // Game States
    @State private var currentQuestion: Question = Question(number1: 1, number2: 1)
    @State private var userAnswer: String = ""
    @State private var score: Int = 0
    @State private var questionsAsked: Int = 0
    @State private var isGameOver: Bool = false // To control game end state
    
    let totalQuestionsPerGame: Int = 5 // Example: 5 questions per game
    
    // Animation States
    @State private var animateScoreUpdate: Bool = false // For star/score feedback
    @State private var pulseAnimationTrigger: Bool = false // For continuous pulsing elements
    
    // Focus State for TextField
    @FocusState private var isAnswerFieldFocused: Bool
    
    var body: some View {
        
        ZStack {
            // Background gradient for the view
            BackgroundGradientView()
            
            VStack(spacing: 20) {
                
                HStack {
                    Spacer()
                    ExitView()
                }
                
                // Score Display
                ScoreView(score: score, maxStars: 5, animate: $animateScoreUpdate)
                    .frame(height: 60) // Consistent height for score display
                
                Spacer()
                
                if !isGameOver {
                    // Question Display
                    QuestionDisplayView(question: currentQuestion, pulse: $pulseAnimationTrigger)
                    
                    // Answer Input
                    AnswerInputView(answer: $userAnswer, isFocused: $isAnswerFieldFocused, onSubmit: processAnswer)
                        .padding(.bottom)
                    
                    // Submit Button
                    SubmitButtonView(pulse: $pulseAnimationTrigger, action: processAnswer)
                } else {
                    // Game Over View
                    GameOverView(score: score, totalQuestions: totalQuestionsPerGame, playAgainAction: restartGame)
                }
                Spacer()
                Spacer()
            }
            .padding()
            .onAppear{
                startGame()
                pulseAnimationTrigger.toggle() // Start pulse animations
            }
        }
    }
    
    // MARK: - Game Logic Methods
        private func startGame() {
            score = 0
            questionsAsked = 0
            isGameOver = false
            generateNewQuestion()
            isAnswerFieldFocused = true // Focus the text field at the start
        }
        
        private func generateNewQuestion() {
            userAnswer = "" // Clear previous answer
            animateScoreUpdate = false // Reset score animation trigger
            
            let number1 = gameData.number // The table we are practicing
            let number2 = multipliers.randomElement() ?? 1 // Random multiplier
            
            currentQuestion = Question(number1: number1, number2: number2)
        }
        
        private func processAnswer() {
            guard !userAnswer.isEmpty, let userAnswerInt = Int(userAnswer) else {
                // Handle invalid input (e.g., non-numeric) if desired
                // For now, just clear and refocus
                userAnswer = ""
                isAnswerFieldFocused = true
                return
            }
            
            if userAnswerInt == currentQuestion.correctAnswer {
                score += 1
                withAnimation(.spring()) { // Animate score update
                    animateScoreUpdate = true
                }
            } else {
                // Handle incorrect answer (e.g., feedback)
                // For now, just moves to next question
            }
            
            questionsAsked += 1
            
            if questionsAsked >= totalQuestionsPerGame {
                isGameOver = true
            } else {
                generateNewQuestion()
            }
            isAnswerFieldFocused = true // Re-focus for the next question
        }
        
        private func restartGame() {
            startGame()
        }
}

struct AnswerInputView: View {
    @Binding var answer: String
    @FocusState.Binding var isFocused: Bool
    var onSubmit: () -> Void

    var body: some View {
        ZStack {
           
            RoundedRectangle(cornerRadius: 25)
                .fill(Material.ultraThinMaterial) // Modern background
                .frame(width: 280, height: 180)
                .shadow(radius: 8)
                
            TextField("?", text: $answer)
                .limitInputLength(value: $answer, length: 3) // Custom modifier
                .keyboardType(.numberPad)
                .font(.system(size: 70, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
                .accentColor(.clear)
                .multilineTextAlignment(.center)
                .frame(width: 150)
                .padding()
                .background(Color.black.opacity(0.2))
                .cornerRadius(20)
                .focused($isFocused)
                .onSubmit(onSubmit)
                .accessibilityLabel("Your answer")
                .accessibilityHint("Enter the product of the two numbers.")
        }
    }
}

#Preview {
    GameView(gameData: Data.sampleData)
}
