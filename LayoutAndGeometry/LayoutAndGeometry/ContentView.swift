//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by bino on 7/11/25.
//

import SwiftUI

struct ContentView: View {
    //let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            //.background(colors[index % 7])
                            .background(Color(
                                hue: hue(for: proxy.frame(in: .global).minY, fullViewHeight: fullView.size.height),
                                saturation: 0.8,
                                brightness: 0.9
                            ))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(opacity(for: proxy.frame(in: .global).minY)) // Apply dynamic opacity
                            .scaleEffect(scale(for: proxy.frame(in: .global).minY, fullViewHeight: fullView.size.height)) // New scale logic
                    }
                    .frame(height: 40)
                }
            }
        }
    }
    
    /// Calculates the opacity for a view based on its vertical position.
    /// Views near the top fade out.
    /// - Parameter minY: The minimum Y-coordinate of the view in the global coordinate space.
    /// - Returns: A Double representing the opacity (0.0 to 1.0).
    private func opacity(for minY: CGFloat) -> Double {
        let startFadeOffset: CGFloat = 200 // Start fading at 200 points from the top
        let fullFadeOffset: CGFloat = 0    // Fully faded (0 opacity) at 0 points (top of screen)
        
        if minY > startFadeOffset {
            return 1.0 // Fully opaque if below the start fade offset
        } else if minY < fullFadeOffset {
            return 0.0 // Fully transparent if above the full fade offset
        } else {
            // Linear interpolation between 1.0 and 0.0
            // As minY goes from 200 to 0, opacity goes from 1.0 to 0.0
            return Double((minY - fullFadeOffset) / (startFadeOffset - fullFadeOffset))
        }
    }
    
    /// Calculates the scale for a view based on its vertical position.
    /// Views near the bottom are larger, views near the top are smaller, with a minimum scale.
    /// - Parameters:
    ///   - minY: The minimum Y-coordinate of the view in the global coordinate space.
    ///   - fullViewHeight: The total height of the GeometryReader's container (the full scrollable area).
    /// - Returns: A Double representing the scale factor (e.g., 0.5 to 1.0).
    private func scale(for minY: CGFloat, fullViewHeight: CGFloat) -> Double {
        let minScale: Double = 0.5 // Minimum scale factor (50%)
        
        // Define the Y-range over which scaling occurs
        // Views at or below this Y will be full size (1.0)
        let startScaleAtY: CGFloat = fullViewHeight * 0.75 // Start scaling down from 75% of screen height
        // Views at or above this Y will be minScale (0.5)
        let endScaleAtY: CGFloat = fullViewHeight * 0.25   // Reach minScale at 25% of screen height
        
        if minY >= startScaleAtY {
            return 1.0 // Fully scaled up if at or near the bottom
        } else if minY <= endScaleAtY {
            return minScale // Scaled to minimum if at or near the top
        } else {
            // Linear interpolation between minScale and 1.0
            // As minY goes from endScaleAtY to startScaleAtY, scale goes from minScale to 1.0
            let normalizedY = (minY - endScaleAtY) / (startScaleAtY - endScaleAtY)
            return minScale + normalizedY * (1.0 - minScale)
        }
    }
    
    /// Calculates the hue for a view based on its vertical position.
    /// Hue changes as the view scrolls from top to bottom.
    /// - Parameters:
    ///   - minY: The minimum Y-coordinate of the view in the global coordinate space.
    ///   - fullViewHeight: The total height of the GeometryReader's container.
    /// - Returns: A Double representing the hue value (0.0 to 1.0).
    private func hue(for minY: CGFloat, fullViewHeight: CGFloat) -> Double {
        // Define the hue range: e.g., from red (0.0) to purple (0.75)
        let startHue: Double = 0.0   // Hue at the very top (e.g., Red)
        let endHue: Double = 0.75    // Hue at the very bottom (e.g., Purple)
        
        // Define the Y-range over which hue transition occurs
        // This makes the hue transition across the entire scrollable area
        let hueTransitionStart: CGFloat = fullViewHeight // Start hue transition from the bottom of the screen
        let hueTransitionEnd: CGFloat = 0                // End hue transition at the top of the screen
        
        // Normalize the minY value within the transition range
        // Clamp the value between 0.0 and 1.0 to ensure it stays within the hue range
        let normalizedY = max(0.0, min(1.0, (minY - hueTransitionEnd) / (hueTransitionStart - hueTransitionEnd)))
        
        // Interpolate the hue based on the normalized Y position
        // If normalizedY is 0.0 (top), hue is startHue. If 1.0 (bottom), hue is endHue.
        return startHue + normalizedY * (endHue - startHue)
    }
}

#Preview {
    ContentView()
}
