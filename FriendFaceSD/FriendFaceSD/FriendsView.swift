//
//  FriendsView.swift
//  SocialNetwork
//
//  Created by Vinz on 6/17/25.
//

import SwiftUI
import SwiftData

struct FriendsView: View {
    @Environment(\.modelContext) var modelContext // Access the ModelContext
    let friendId: String // Receive the friend's ID
    @State private var friendUser: User? // State to hold the fetched friend's User object
    
    var body: some View {
        List {
            Section(header: Text("Friend Details")) {
                if let friendUser = friendUser {
                    Text("Name: \(friendUser.name)")
                    Text("Age: \(friendUser.age)")
                    Text("Email: \(friendUser.email)")
                    Text("Company: \(friendUser.company)")
                    Text("Address: \(friendUser.address)")
                    Text("About: \(friendUser.about)")
                    Text("Registered: \(friendUser.registered.formatted(date: .abbreviated, time: .shortened))")
                } else {
                    Text("Friend details not available.")
                }
            }
            
            Section(header: Text("Tags")) {
                if let friendUser = friendUser {
                    ForEach(friendUser.tags, id: \.self) { tag in
                        Text("#\(tag)")
                    }
                }
            }
            
            Section(header: Text("Friends")) {
                if let friendUser = friendUser {
                    ForEach(friendUser.friends) { friend in
                        NavigationLink(destination: FriendsView(friendId: friend.id)) {
                            Text(friend.name)
                        }
                    }
                }
            }
        }
        .navigationTitle(friendUser?.name ?? "Friend") // Use optional chaining for navigation title
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await fetchFriendUser()
        }
    }
    
    func fetchFriendUser() async {
        let predicate = #Predicate<User> { $0.id == friendId } // Create a predicate to find the user by ID
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        
        do {
            let users = try modelContext.fetch(fetchDescriptor)
            friendUser = users.first // Assign the first matching user
        } catch {
            print("Failed to fetch friend user: \(error.localizedDescription)")
        }
    }
}
