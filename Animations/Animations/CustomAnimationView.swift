//
//  CustomAnimationView.swift
//  Animations
//
//  Created by @binoooh on 5/4/25.
//

import SwiftUI

struct CustomAnimationView: View {
    
    @State private var animationAmont = 1.0
    @State private var pulseAmont = 1.0
    
    var body: some View {
        VStack {
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
            
            // this applies a linear animation type to the scaleEffect()
            // whenever animationAmount value changes
            // MARK: .animation(.linear, value: animationAmont)
            
            // this applies a spring animation type to the scaleEffect()
            // whenever animationAmount value changes
            // this makes the button scale up quickly then bounce a lot
            // MARK: .animation(.spring(duration: 1, bounce: 0.9), value: animationAmont)
            
            // this applies an easing in and out animation that last for 2 secs
            // MARK: .animation(.easeInOut(duration: 2), value: animationAmont)
            
            // this applies an easing in and out animation that repeats and autoreverses
            // creating a one second animation that bounces up and down
            // MARK: .animation(
            //    .easeIn(duration: 1)
            //    .repeatCount(3, autoreverses: true),
            //    value: animationAmont
            //)
            
            // this applies easing in and out animation that repeats forever
            // and autoreverses
            .animation(
                .easeInOut(duration: 1)
                .repeatForever(autoreverses: true),
                value: animationAmont
            )
            
            Spacer(minLength: 10)
            
            Button("Pulse") {
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
        
            // this creates an overlay to the button
            // creating a stroke around the button
            // that eases in and out forever
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(pulseAmont)
                    .opacity(2 - pulseAmont)
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false),
                        value: pulseAmont
                    )
            )
            .onAppear{
                pulseAmont = 2
            }
            
            
        }
        .padding(.all, 50)
    }
}

#Preview {
    CustomAnimationView()
}
