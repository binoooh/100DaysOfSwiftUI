//
//  BackgroundGradientView.swift
//  Edutainment
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(.sRGB, red: Double((hex >> 16) & 0xff) / 255, green: Double((hex >> 8) & 0xff) / 255, blue: Double((hex >> 0) & 0xff) / 255, opacity: alpha)
    }
}

// A simple view for the background gradient.
struct BackgroundGradientView: View {
    
    var body: some View {
//            LinearGradient(
//                colors: [.red, .yellow],
//                startPoint: .bottom,
//                endPoint: .top
//            )
//            .opacity(0.7)
//            .ignoresSafeArea()
                LinearGradient(gradient: Gradient(colors: [Color(hex: 0x9F7FFF), Color(hex: 0x8055FE)]), startPoint: .top, endPoint: .bottom)
                    .opacity(0.7)
                    .ignoresSafeArea() // Makes the gradient extend to the screen edges.
        }
}

#Preview {
    BackgroundGradientView()
}
