//
//  BindingTestView.swift
//  Bookworm
//
//  Created by Vinz on 6/3/25.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool // Binds to the rememberMe @State property
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct BindingCustomComponent: View {
    
    @State private var rememberMe = false // Binded to isOn @Binding property
    
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

#Preview {
    BindingCustomComponent()
}
