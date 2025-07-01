//
//  TabExample.swift
//  HotProspects
//
//  Created by bino on 6/28/25.
//

import SwiftUI

struct TabExample: View {
    
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "house")
                }
                .tag("Two")
        }
    }
}

#Preview {
    TabExample()
}
