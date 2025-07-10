//
//  PinchGesture.swift
//  Flashzilla
//
//  Created by bino on 7/1/25.
//

import SwiftUI

struct PinchGestureSample: View {
    
    // For pinch gesture
    @State private var initialScale = 0.0
    @State private var finalScale = 1.0
    
    var body: some View {
        VStack {
             // Pinch gesture
             Text("Pinch Me")
                 .scaleEffect(finalScale + initialScale)
                 .gesture(
                     MagnifyGesture()
                         .onChanged { value in
                             initialScale = value.magnification - 1
                         }
                         .onEnded { value in
                             finalScale += initialScale
                             initialScale = 0
                         }
                 )
         }
         .padding()
    }
}

#Preview {
    PinchGestureSample()
}
