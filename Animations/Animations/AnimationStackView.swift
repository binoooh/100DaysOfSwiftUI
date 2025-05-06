//
//  AnimationStackView.swift
//  Animations
//
//  Created by @binoooh on 5/4/25.
//

// The order on which you put your animation matters

import SwiftUI

struct AnimationStackView: View {
    
    @State private var enabled = false
    
    var body: some View {
        Button("Tap Me") {
            // toggle from true to false
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .foregroundStyle(.white)
        // this animation controls modifiers above it.
        // In this case the background() modifier
        // because both animation and background uses enabled property
        .animation(.default, value: enabled)
    
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        // this animation controls modifiers above it.
        // In this case the clipShape() modifier
        // because both animation and clipshape uses enabled property
        .animation(.spring(duration: 1, bounce: 0.9), value: enabled)
    }
}

#Preview {
    AnimationStackView()
}
