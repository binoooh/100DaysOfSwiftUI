//
//  UsersView.swift
//  SocialNetwork
//
//  Created by Vinz on 6/16/25.
//

import SwiftUI
import SwiftData

// Temporary Codable struct for decoding Users from JSON
struct UserCodable: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [FriendCodable] // Use the Codable version of Friend
}

// Temporary Codable struct for decoding Friends from JSON
struct FriendCodable: Codable, Identifiable {
    let id: String
    let name: String
}

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) var users: [User]

    var body: some View {
        List {
            ForEach(users) { user in
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
                        UserDetailsView(user: user)
                    }
                    .foregroundStyle(.blue)
                }
                .padding(.vertical, 5)
            }
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

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            // Decode into the temporary Codable struct
            let decodedCodableUsers = try decoder.decode([UserCodable].self, from: data)

            // Convert Codable structs to SwiftData models and insert into context
            for codableUser in decodedCodableUsers {
                // Convert Codable Friends to SwiftData Friends
                let swiftDataFriends = codableUser.friends.map { codableFriend in
                    Friend(id: codableFriend.id, name: codableFriend.name)
                }

                let newUser = User(
                    id: codableUser.id,
                    isActive: codableUser.isActive,
                    name: codableUser.name,
                    age: codableUser.age,
                    company: codableUser.company,
                    email: codableUser.email,
                    address: codableUser.address,
                    about: codableUser.about,
                    registered: codableUser.registered,
                    tags: codableUser.tags,
                    friends: swiftDataFriends // Assign the SwiftData Friend objects
                )
                modelContext.insert(newUser)
            }
        } catch {
            print("Invalid Data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    UsersView()
        .modelContainer(for: User.self, inMemory: true)
}
