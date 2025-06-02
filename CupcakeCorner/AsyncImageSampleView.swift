//
//  AsyncImageSampleView.swift
//  CupcakeCorner
//
//  Created by Vinz on 5/31/25.
//

import SwiftUI

struct AsyncImageSampleView: View {
    var body: some View {
        // AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("Error loading image")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    AsyncImageSampleView()
}
