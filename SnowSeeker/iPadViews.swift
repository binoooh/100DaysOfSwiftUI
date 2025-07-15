//
//  iPadViews.swift
//  SnowSeeker
//
//  Created by bino on 7/13/25.
//

import SwiftUI

struct iPadViews: View {
    var body: some View {
        NavigationSplitView(preferredCompactColumn: .constant(.detail)) {
            NavigationLink("Primary") {
                Text("New view")
            }
        } detail: {
            Text("Content")
                .navigationTitle("Content View")
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    iPadViews()
}
