//
//  SleepGraphic.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import SwiftUI

struct SleepGraphic: View {
    var body: some View {
        Image(.sleep)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
}

#Preview {
    SleepGraphic()
}
