//
//  MultiSelection.swift
//  HotProspects
//
//  Created by bino on 6/28/25.
//

import SwiftUI

struct MultiSelection: View {
    
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selection = Set<String>()
    
    var body: some View {
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        
        if !selection.isEmpty {
            Text("You selected: \(selection.formatted())")
        }
        
        EditButton()
    }
}

#Preview {
    MultiSelection()
}
