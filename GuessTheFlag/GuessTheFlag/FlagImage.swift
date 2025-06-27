//
//  FlagView.swift
//  GuessTheFlag
//
//  Created by bino on 6/26/25.
//

import SwiftUI

// Project 3 - Challenge 2
struct FlagImage: View {
    var imageName: String
    //var width: CGFloat
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(style: StrokeStyle(lineWidth: 3)))
            .shadow(radius: 5)
    }
}

#Preview {
    FlagImage(imageName: "US")
}
