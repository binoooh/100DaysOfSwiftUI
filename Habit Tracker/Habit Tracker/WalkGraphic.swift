//
//  WalkGraphic.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import SwiftUI

struct WalkGraphic: View {
    var body: some View {
        Image(.walk)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
}

#Preview {
    WalkGraphic()
}
