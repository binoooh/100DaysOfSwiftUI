//
//  ComparableExampleView.swift
//  BucketList
//
//  Created by Vinz on 6/21/25.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
        var firstName: String
        var lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ComparableExampleView: View {
    
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

#Preview {
    ComparableExampleView()
}
