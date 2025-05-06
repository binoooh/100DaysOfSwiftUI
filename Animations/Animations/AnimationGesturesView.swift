//
//  AnimationGesturesView.swift
//  Animations
//
//  Created by @binoooh on 5/4/25.
//

import SwiftUI

struct AnimationGesturesView: View {
    // this stores the drag value
    @State private var letterDragAmount = CGSize.zero
    @State private var cardletterDragAmount = CGSize.zero
    @State private var enabled = false
    let letters = Array("Hello from SwiftUI")
    
    var body: some View {
        VStack {
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count, id: \.self) { num in
                    Text(String(letters[num]))
                        .padding(2)
                        .font(.title)
                        .background(enabled ? .blue : .red)
                        .offset(letterDragAmount)
                        .animation(.linear.delay(Double(num) / 20), value: letterDragAmount)
                }
            }
            .padding(.bottom)
            .gesture(
                DragGesture()
                    .onChanged { letterDragAmount = $0.translation }
                    .onEnded { _ in
                        letterDragAmount = .zero
                        enabled.toggle()
                    }
            )
            
            // this creates a card like shape
            LinearGradient(colors: [.red, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(.rect(cornerRadius: 10))
                // adjusts the X and Y coordinate of a view
                .offset(cardletterDragAmount)
                // dragGesture monitors the the drag gesture as we move the view
                // around the screen
                .gesture(
                    DragGesture()
                        .onChanged{
                            // whenever we drag the view,
                            // we save the drag translation to letterDragAmount
                            cardletterDragAmount = $0.translation
                        }
                        // resets rhe letterDragAmount to zero
                        // sending the view back to its original position
                        .onEnded { _ in
                            withAnimation(.bouncy) {
                                // we ad an explicit animation with bounce effect
                                // to onEnded giving a bounce animation
                                // whenever the view is sent back to its orig position
                                cardletterDragAmount = .zero
                            }
                        }
                    
                )
            // add an implicit animation with bounce effect
            // whenever the view is sent back to its orig position
            // .bouncy is the same as .spring
            // MARK: .animation(.bouncy, value: cardletterDragAmount)
        }
    }
}

#Preview {
    AnimationGesturesView()
}
