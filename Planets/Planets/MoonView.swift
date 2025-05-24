//
//  MoonView.swift
//  Planets
//
//  Created by @binoooh on 5/23/25.
//

import SwiftUI

struct MoonView: View {
    
    let moon: Moon
    
    @State private var isShowingMoonItemView = false
    
    var body: some View {
        VStack {
            Image(moon.image)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .padding(.bottom)
            
            Text(moon.name)
                .font(.system(size: 18).bold())
                .fontDesign(.monospaced)
                .foregroundStyle(.white)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
                //.fixedSize(horizontal: true, vertical: true)
        }
        .frame(width: 80, height: 80)
        .onTapGesture {
            isShowingMoonItemView.toggle()
        }
        .fullScreenCover(isPresented: $isShowingMoonItemView) {
            MoonItemView(moon: moon)
        }
//        .sheet(isPresented: $isShowingMoonItemView) {
//            MoonItemView(moon: moon)
//        }
    }
}

#Preview {
    
    let moons: [String: Moon] = Bundle.main.decode("moons.json")
    
    MoonView(moon: moons["moon"]!)
        .preferredColorScheme(.dark)
}
