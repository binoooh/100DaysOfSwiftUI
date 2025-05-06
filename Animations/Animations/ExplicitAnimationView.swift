//
//  ExplicitAnimationView.swift
//  Animations
//
//  Created by @binoooh on 5/4/25.
//

import SwiftUI

struct ExplicitAnimationView: View {
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            // this explicitly animates the button
            // and it will be applied to the 3D rotation effect
            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        // this tells the button to rotate 360 degress on its Y axis
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

#Preview {
    ExplicitAnimationView()
}
