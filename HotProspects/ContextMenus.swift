//
//  ContextMenuExample.swift
//  HotProspects
//
//  Created by bino on 6/28/25.
//

import SwiftUI

struct ContextMenus: View {
    
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello")
                .padding()
                .contextMenu {
                    Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                        backgroundColor = .red
                    }
                    Button("Green", systemImage: "mail.fill", role: .cancel) {
                        backgroundColor = .green
                    }
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

#Preview {
    ContextMenus()
}
