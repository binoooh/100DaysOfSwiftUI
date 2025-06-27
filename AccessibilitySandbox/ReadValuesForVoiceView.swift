//
//  ReadValuesForVoiceView.swift
//  AccessibilitySandbox
//
//  Created by Vinz on 6/26/25.
//

import SwiftUI

struct ReadValuesForVoiceView: View {
    
    @State private var value: Int = 10
    
    var body: some View {
        VStack {
            Text("Value \(value)")
            Button("Increment") {
                value += 1
            }
            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement() // groups the views
        .accessibilityLabel("Value") // read as Value via Voice over
        .accessibilityValue(String(value)) // read the value via Voice over
        // Below will read the values per action
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled.")
            }
        }
    }
}

#Preview {
    ReadValuesForVoiceView()
}
