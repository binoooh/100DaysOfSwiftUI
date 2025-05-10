//
//  LevelsImageView.swift
//  Edutainment
//
//  Created by @binoooh on 5/7/25.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}

struct LevelsImageView: View {

    let gameData: GameData
    @State private var xOffset: CGFloat = -200

    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(Color.random.opacity(0.5))
                .frame(width: 90, height: 90)
                .scaledToFit()
                .cornerRadius(8)
//                .overlay(
//                    Rectangle()
//                        .fill(LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .leading, endPoint: .trailing))
//                        .frame(width: 90, height: 90)
//                        .offset(x: xOffset)
//                )
//                .mask(
//                    Rectangle()
//                        .fill(.black) // Mask the gradient with a black rectangle
//                        .frame(width: 90, height: 90)
//                        .blur(radius: 5)
//                )
//                .border(.gray, width: 2) // Adds a border to the rectangle
            
            Image(systemName: gameData.image)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(8)
                .foregroundColor(Color.white)
                .shadow(radius: 5)
        }
        .onAppear {
                    withAnimation(.linear(duration: 2).repeatForever()) {
                        xOffset = 200
                    }
                }
    }
}

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsImageView(gameData: Data.sampleData)
    }
}
