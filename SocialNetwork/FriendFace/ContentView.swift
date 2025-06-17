//
//  ContentView.swift
//  SocialNetwork
//
//  Created by Vinz on 6/16/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users = [User]()
    
    var body: some View {
        List {
            ForEach(users, id: \.id) { user in
                Text(user.company)
                Text(user.about)
            }
        }
        .task {
            await fetchUsers()
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
            if let decordUsers = try? JSONDecoder().decode(Users.self, from: data) {
                users = decordUsers.user
                print(users)
            }
        } catch {
            print("Invalid Data")
        }
    }
}

#Preview {
    ContentView()
}
