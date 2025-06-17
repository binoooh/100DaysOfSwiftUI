//
//  UserDetailsView.swift
//  SocialNetwork
//
//  Created by Vinz on 6/16/25.
//

import SwiftUI

struct UserDetailsView: View {
    
    let user: User
    let allUsers: [User] // Property to hold the full user list
    
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
                ForEach(user.friends, id: \.id) { friend in
                    // Find the full User object for the friend and pass it to FriendsView
                    NavigationLink(destination: FriendsView(user: findFriend(withId: friend.id))) {
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    /// Finds a user from the `allUsers` array that matches the provided friend ID.
    /// - Parameter id: The ID of the friend to find.
    /// - Returns: The corresponding `User` object.
    func findFriend(withId id: String) -> User {
        // Search the array for a user with a matching ID.
        if let friendUser = allUsers.first(where: { $0.id == id }) {
            return friendUser
        }
        
        // This should not happen with the provided data, but it's good practice
        // to handle cases where a friend might not be in the user list.
        fatalError("Friend with ID \(id) not found in the user list.")
    }
}
