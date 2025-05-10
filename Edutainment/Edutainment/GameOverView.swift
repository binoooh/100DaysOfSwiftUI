//
//  GameOverView.swift
//  Edutainment
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI

struct GameOverView: View {
    let score: Int
    let totalQuestions: Int
    var playAgainAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Game Over!")
                .font(.largeTitle.bold())
                .foregroundColor(.orange)
                .textCase(.uppercase)
            
            Text("Your Score: \(score) / \(totalQuestions)")
                .font(.title2)
                .foregroundColor(.accentColor.opacity(0.8))
            
            Button(action: playAgainAction) {
                Text("Play Again")
                    .font(.title3.weight(.semibold))
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .shadow(radius: 5)
            }
        }
        .padding(30)
        .background(Material.regularMaterial)
        .cornerRadius(20)
        .shadow(radius: 10)
        .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Game Over. Your score is \(score) out of \(totalQuestions).")
    }
}

#Preview {
    GameOverView(score: 24, totalQuestions: 5, playAgainAction: {})
}
