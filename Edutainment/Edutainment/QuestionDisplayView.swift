//
//  QuestionDisplayView.swift
//  Edutainment
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI

struct QuestionDisplayView: View {
    let question: Question
    @Binding var pulse: Bool

    private func numberImage(for number: Int) -> String {
        // Assuming you have images named "1.png", "2.png" etc. or use SF Symbols
        // For simplicity, let's use Text here, but Image views are in the original
        // return "\(number)" // If using images named "1", "2"
        return String(number) // Using Text directly for this example
    }

    var body: some View {
        HStack(spacing: 15) {
            // Number 1
            Text(numberImage(for: question.number1))
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
                .background(Color.random.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .accessibilityLabel("First number: \(question.number1)")

            // Multiplication Sign
            Image(systemName: "multiply") // Using SF Symbol
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(.white)
                .scaleEffect(pulse ? 1.15 : 0.95)
                .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: pulse)
                .accessibilityHidden(true) // Decorative

            // Number 2
            Text(numberImage(for: question.number2))
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
                .background(Color.random.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .accessibilityLabel("Second number: \(question.number2)")
        }
        .padding()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Question: \(question.number1) times \(question.number2)")
    }
}

#Preview {
    QuestionDisplayView(question: Question(number1: 1, number2: 2), pulse: .constant(true))
}
