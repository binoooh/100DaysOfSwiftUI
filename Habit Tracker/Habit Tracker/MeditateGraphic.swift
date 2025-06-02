//
//  MeditationGraphic.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import SwiftUI

struct MeditateGraphic: View {
    var body: some View {
        Image(.meditate)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
}

#Preview {
    MeditateGraphic()
}
