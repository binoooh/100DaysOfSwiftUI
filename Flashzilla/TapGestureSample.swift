//
//  GesturesSample.swift
//  Flashzilla
//
//  Created by bino on 7/1/25.
//

import SwiftUI

struct TapGestureSample: View {
    
    var body: some View {
        VStack {
            // Tap gesture
            Text(
                "Double Tap Me"
            )
            .onTapGesture(
                count: 2
            ) {
                print(
                    "Double Tapped!"
                )
            }
            .padding(
                .vertical,
                20
            )
            // Long press gesture
            Text(
                "Long Press Me"
            )
            .onLongPressGesture(
                minimumDuration: 2
            ) {
                print(
                    "Long Pressed!"
                )
                }
        }
    }
}

#Preview {
    TapGestureSample()
}
