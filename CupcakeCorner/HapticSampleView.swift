//
//  HapticSampleView.swift
//  CupcakeCorner
//
//  Created by Vinz on 6/1/25.
//

import SwiftUI

struct HapticSampleView: View {
    
    @State private var counter = 0
    
    var body: some View {
        Button("Tap count: \(counter)") {
            counter += 1
        }
        // Easy way to generate haptics
        .sensoryFeedback(.increase, trigger: counter)
    }
}

#Preview {
    HapticSampleView()
}
