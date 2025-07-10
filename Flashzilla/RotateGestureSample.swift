//
//  RotateGesture.swift
//  Flashzilla
//
//  Created by bino on 7/1/25.
//

import SwiftUI

struct RotateGestureSample: View {
    // For rotation gesture
    @State private var initialRotation = Angle.zero
    @State private var finalRotation = Angle.zero
    var body: some View {
        VStack {
            // Rotation gesture
            Text("Rotate Me")
                .rotationEffect(finalRotation + initialRotation)
                .gesture(
                    RotateGesture()
                        .onChanged { value in
                            initialRotation = value.rotation
                        }
                        .onEnded { value in
                            finalRotation += initialRotation
                            initialRotation = .zero
                        }
                )
        }
    }
}

#Preview {
    RotateGestureSample()
}
