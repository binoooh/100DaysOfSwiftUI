//
//  ImplicitAnimationView.swift
//  Animations
//
//  Created by @binoooh on 5/4/25.
//

import SwiftUI

struct ImplicitAnimationView: View {
    
    @State private var animationAmont = 1.0
    
    var body: some View {
        Button("Tap Me") {
            animationAmont += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        // this scales the button with no animation
        // by animationAmount value everytime the button is clicked
        .scaleEffect(animationAmont)
        // this adds gaussian blur to the button when tapped
        .blur(radius: (animationAmont - 1) * 3)
        // this applies an implicit animation
        // with default animation type to the scaleEffect()
        // whenever animationAmount value changes
        .animation(.default, value: animationAmont)
    }
}

#Preview {
    ImplicitAnimationView()
}
