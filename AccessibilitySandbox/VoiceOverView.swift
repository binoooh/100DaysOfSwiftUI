//
//  VoiceOverView.swift
//  AccessibilitySandbox
//
//  Created by Vinz on 6/25/25.
//

//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Vinz on 6/25/25.
//

import SwiftUI

struct VoiceOverView: View {
    
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]
    
    @State private var selectPicture = Int.random(in: 0...3)
    
    var body: some View {
        // It's best to use a button rather than tap gesture
        Button {
            selectPicture = Int.random(in: 0...3)
        } label: {
            Image(pictures[selectPicture])
                .resizable()
                .scaledToFit()
//                .onTapGesture {
//                    selectPicture = Int.random(in: 0...3)
//                }
        }
        .accessibilityLabel(labels[selectPicture])
    }
}

#Preview {
    VoiceOverView()
}
