//
//  ImageResizeView.swift
//  Moonshot
//
//  Created by @binoooh on 5/15/25.
//

//  Topics:
//  1. Resizing images with .resizable
//  2. Scaling images with scaledToFill or scaledToFit
//  3. Displaying images on a container with .containerRelativeFrame

import SwiftUI

struct ImageResizeView: View {
    var body: some View {
        Image(.loopMac)
            .resizable()
            .scaledToFit()
            // Give this image a frame
            // relative to the horizontal size of its parent
            .containerRelativeFrame(.horizontal) { size, axis in
                // the size is the container = fullscreen
                // the axis is .horizontal
                size * 0.8 // 80% of the container's width coz .horizontal
            }
    }
}

#Preview {
    ImageResizeView()
}
