//
//  SubmitButtonView.swift
//  Edutainment
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI

struct SubmitButtonView: View {
    @Binding var pulse: Bool
    var action: () -> Void

    var body: some View {
        ZStack {
            Button(action: action) {
                Image(systemName: "circlebadge.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .foregroundStyle(.red)
                    .shadow(radius: 5)
            }
            Text("GO!")
                .font(.system(size: 36, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .padding(.bottom, 5)
        }
        .scaleEffect(pulse ? 1.1 : 0.9)
        .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: pulse)
        .accessibilityLabel("Submit answer")
    }
}

#Preview {
    SubmitButtonView(pulse: .constant(true), action: { })
}
