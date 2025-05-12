//
//  StoreUserSettings.swift
//  iExpense
//
//  Created by @binoooh on 5/11/25.
//

import SwiftUI

struct StoreUserSettings: View {
    // We use AppStorage to store any data using a key i.e. TapCount
    @AppStorage("TapCount") var tapCount: Int = 0
    var body: some View {
        Button("Tap count: \(tapCount)")
        {
            tapCount += 1
        }
    }
}

#Preview {
    StoreUserSettings()
}
