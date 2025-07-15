//
//  UsingGroups.swift
//  SnowSeeker
//
//  Created by bino on 7/13/25.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct UsingGroups: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var layoutVertically = false
    
    var body: some View {
        ViewThatFits {
            Rectangle()
                .frame(width: 500, height: 200)

            Circle()
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    UsingGroups()
}
