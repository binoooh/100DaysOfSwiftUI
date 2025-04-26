//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by @binoooh on 4/25/25.
//

import SwiftUI

// Project 3 - Challenge 3
// We can create own own custom view modifiers
struct Title: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .textCase(.uppercase)
            .font(.largeTitle.weight(.heavy))
            .foregroundStyle(.blue)
            .padding()
    }
}

// It is advisable to create an extension if we have custom view modifiers
extension View {
    
    public func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct ContentView: View {
    
    var body: some View {
        ZStack {
    
            RadialGradient(colors: [.red, .yellow], center: .bottom, startRadius: 100, endRadius: 500)
            
            // Project 3 - Challenge 3
            // This is how we can use our custom view modifiers
            // We call the method from extension View
            Text("This is a title")
                .titleStyle()
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
