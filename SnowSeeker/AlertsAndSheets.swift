//
//  AlertsAndSheets.swift
//  SnowSeeker
//
//  Created by bino on 7/13/25.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct AlertsAndSheets: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    var body: some View {
        Button("Tap Me") {
            selectedUser = User()
        }
        .sheet(item: $selectedUser) { user in
            Text(user.id)
                .presentationDetents([.medium, .large])
        }
        .padding()
        
        Button("Alert Me") {
            isShowingUser = true
        }
        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
            Button(user.id) { }
        }
    }
}

#Preview {
    AlertsAndSheets()
}
