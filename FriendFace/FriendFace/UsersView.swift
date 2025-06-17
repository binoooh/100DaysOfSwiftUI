//
//  UsersView.swift
//  SocialNetwork
//
//  Created by Vinz on 6/16/25.
//

import SwiftUI

struct UsersView: View {
    
    @State private var users = [User]()
    
    var body: some View {
        List(users, id: \.id) { user in
            // Using a VStack for better layout
            VStack(alignment: .leading, spacing: 5) {
                Text(user.name)
                    .font(.headline)
                Text("Company: \(user.company)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("\(user.email)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                NavigationLink("View More") {
                    UserDetailsView(user: $users)
                }
                .foregroundStyle(.blue)
                //.disabled(user.isActive ? false : true)
            }
            .padding(.vertical, 5)
        }
        .navigationTitle("Friend Face")
        .task {
            if users.isEmpty {
                await fetchUsers()
            }
        }
    }
    func fetchUsers() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
        else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Create and configure the JSON decoder
            let decoder = JSONDecoder()
            // Ensure to handle correct date format
            decoder.dateDecodingStrategy = .iso8601
            
            // Decode an array of User objects directly
            if let decodedUsers = try? decoder.decode([User].self, from: data) {
                users = decodedUsers
            }
        } catch {
            print("Invalid Data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    UsersView()
}
