//
//  ScrollingView.swift
//  Moonshot
//
//  Created by @binoooh on 5/15/25.
//

//  Topics:
//  1. LazyVStack and LazyHStack

import SwiftUI

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(text: String) {
        print(text)
        self.text = text
    }
}

struct ScrollingView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText(text: "Row \($0)")
                        .font(.headline)
                }
            }
            .frame(width: .infinity)
        }
        
    }
}

#Preview {
    ScrollingView()
}
