//
//  User.swift
//  SocialNetwork
//
//  Created by Vinz on 6/16/25.
//

import Foundation
import SwiftData

@Model
class User {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date // Decoded as a Date object
    var tags: [String] // Decoded as an array of Strings
    @Relationship(deleteRule: .cascade) var friends: [Friend] // Mark as a relationship with cascade devare

    init(id: String, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, tags: [String], friends: [Friend]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
}
