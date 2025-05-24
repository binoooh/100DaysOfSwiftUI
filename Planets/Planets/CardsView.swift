//
//  CardsView.swift
//  Planets
//
//  Created by @binoooh on 5/18/25.
//

import SwiftUI

struct CardsView: View {
    
    let topColor: Color
    let midColor: Color
    let bottomColor: Color
    let isFullScreen: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: isFullScreen ? 20 : 30)
                .fill(
                    LinearGradient(
                        gradient:
                            Gradient(colors: [topColor, midColor, bottomColor]), startPoint: .top, endPoint: .bottom
                    )
                )
                .frame(width: isFullScreen ? UIScreen.main.bounds.width : 315,
                       height: isFullScreen ? UIScreen.main.bounds.height : 450)
                .shadow(radius: isFullScreen ? 0 : 10)
                .statusBarHidden(isFullScreen)
                .ignoresSafeArea(.all, edges: isFullScreen ? .all : [])
            
        }
    }
}

#Preview {
    
    CardsView(topColor: Color.black, midColor: Color.gray, bottomColor: Color.white, isFullScreen: false)
}
