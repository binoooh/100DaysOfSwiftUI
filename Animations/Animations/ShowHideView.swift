//
//  ShowHideView.swift
//  Animations
//
//  Created by @binoooh on 5/4/25.
//

import SwiftUI

struct ShowHideView: View {
    
    @State private var isRed = false
    
    var body: some View {
        VStack {
            
            Button("Tap Me") {
                // Add default animation when toggled
                withAnimation {
                    isRed.toggle()
                }
            }
            // use our state as a condition for showing our rectangle
            // .scale will scale the view from small to large
            if isRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    // this scales the view
                    // MARK: .transition(.scale)
                    // this scales the view with fade out effect
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

#Preview {
    ShowHideView()
}
