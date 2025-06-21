//
//  UnavailableView.swift
//  Instafilter
//
//  Created by Vinz on 6/19/25.
//

import SwiftUI

struct UnavailableView: View {
    var body: some View {
        ContentUnavailableView {
            Label("No Snippoets Found", systemImage: "swift")
        } description: {
            Text("You have no saved snippets yet.")
        } actions: {
            Button("Create Snippet") {
                
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    UnavailableView()
}
