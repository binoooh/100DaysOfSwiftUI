//
//  PrayGraphic.swift
//  Habit Tracker
//
//  Created by Vinz on 5/30/25.
//

import SwiftUI

struct PrayGraphic: View {
    var body: some View {
        Image(.pray)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
}

#Preview {
    PrayGraphic()
}
