//
//  ScoreView.swift
//  Edutainment
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI

struct ScoreView: View {
        let score: Int
        let maxStars: Int
        @Binding var animate: Bool // To trigger animation on score change

        var body: some View {
            HStack {
                if score > 0 {
                    ForEach(0..<min(score, maxStars), id: \.self) { index in
                        Image(systemName: "star.fill") // Using SF Symbols for stars
                            .foregroundColor(.yellow)
                            .font(.system(size: 50))
                            .shadow(color: .orange, radius: 2, x: 1, y: 1)
                            .scaleEffect(animate && index == score - 1 ? 1.5 : 1.0) // Animate the latest star
                            .animation(.spring(response: 0.3, dampingFraction: 0.3).delay(Double(index) * 0.1), value: animate)
                            .transition(.scale.combined(with: .opacity))
                    }
                } else {
                    Text("Score: 0")
                        .font(.headline.bold().weight(.heavy))
                        .foregroundColor(.white)
                }
            }
            .onChange(of: score) { _ in
                 // This ensures `animate` is true when score changes, triggering animation
                if score > 0 { animate = true }
                // Reset animate after a short delay so it can be triggered again
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    animate = false
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Current score: \(score)")
        }
}

#Preview {
    ScoreView(score: 2, maxStars: 5, animate: .constant(true))
}
