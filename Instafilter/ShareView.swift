//
//  ShareView.swift
//  Instafilter
//
//  Created by Vinz on 6/19/25.
//

import SwiftUI

struct ShareView: View {
    var body: some View {
        let image = Image(.example)
        ShareLink(item: image, preview: SharePreview("Iguana", image: image)) {
            Label("Check this", systemImage: "airplane")
        }
    }
}

#Preview {
    ShareView()
}
