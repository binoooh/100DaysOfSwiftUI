//
//  HeaderImageView.swift
//  Edutainment
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI

// View for displaying the header image.
struct HeaderImageView: View {
    // Constants for image properties to improve maintainability.
    private let imageName: String = "header"
    private let imageWidth: CGFloat = 300
    private let imageHeight: CGFloat = 100
    private let cornerRadius: CGFloat = 12 // Slightly increased corner radius
    @State var pulse: Bool = false

    var body: some View {
        ZStack {
            
            Image(imageName)
                .resizable()
                .scaledToFit() // Ensures the image maintains its aspect ratio.
                .frame(width: imageWidth, height: imageHeight)
                .clipped() // Clips the image to its bounds, necessary for cornerRadius.
                .cornerRadius(cornerRadius)
                .shadow(radius: 5) // Added a subtle shadow for depth
            Text("LET'S PLAY!")
                .font(.system(size: 32, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .padding(.bottom, 12)
        }
        .scaleEffect(pulse ? 1.0 : 0.9)
        .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: pulse)
        .onAppear {
            pulse.toggle()
        }
            
    }
}

#Preview {
    HeaderImageView()
}
