//
//  AnimationBindingsView.swift
//  Animations
//
//  Created by @binoooh on 5/4/25.
//

import SwiftUI

struct AnimationBindingsView: View {
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack {
            // the stepper amount is binded to animationAmount
            // whenever the value of the Stepper changes
            // it applies an animation to the button since they are both
            // binded to animationAmount property
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true)
            ), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
        }
    }
}

#Preview {
    AnimationBindingsView()
}
