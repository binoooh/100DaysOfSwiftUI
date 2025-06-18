//
//  UserDetailsView.swift
//  SocialNetwork
//
//  Created by Vinz on 6/16/25.
//

import SwiftUI

struct UserDetailsView: View {
    
    let user: User
    @Environment(\.modelContext) var modelContext // Access the ModelContext to fetch other users
    
    var body: some View {
        List {
            Section(header: Text("User Details")) {
                Text("Age: \(user.age)")
                Text("Address: \(user.address)")
                Text("About: \(user.about)")
                Text("Registered: \(user.registered.formatted(date: .abbreviated, time: .shortened))")
            }
            
            Section(header: Text("Tags")) {
                ForEach(user.tags, id: \.self) { tag in
                    Text("#\(tag)")
                }
            }
            
            Section(header: Text("Friends")) {
                ForEach(user.friends) { friend in // Iterate directly over user.friends
                    // We need to find the full User object for the friend to pass to FriendsView.
                    // This can be done with a @Query in FriendsView or by passing the model context and ID.
                    // A simpler way here is to make FriendsView accept a Friend ID and query for the User directly.
                    NavigationLink(destination: FriendsView(friendId: friend.id)) { // Pass friend's ID
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}
