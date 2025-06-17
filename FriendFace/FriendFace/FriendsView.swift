//
//  FriendsView.swift
//  SocialNetwork
//
//  Created by Vinz on 6/17/25.
//

import SwiftUI

struct FriendsView: View {
    
    let user: User
    
    var body: some View {
        List {
            Section(header: Text("Friend Details")) {
                Text("Name: \(user.name)")
                Text("Age: \(user.age)")
                Text("Email: \(user.email)")
                Text("Company: \(user.company)")
                Text("Address: \(user.address)")
                Text("About: \(user.about)")
                Text("Registered: \(user.registered.formatted(date: .abbreviated, time: .shortened))")
            }
            
//            Section(header: Text("Tags")) {
//                ForEach(user.tags, id: \.self) { tag in
//                    Text("#\(tag)")
//                }
//            }
            
//            Section(header: Text("Friends")) {
//                ForEach(user.friends, id: \.id) { friend in
//                    Text(friend.name)
//                }
//            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
