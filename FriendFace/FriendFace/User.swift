//
//  User.swift
//  SocialNetwork
//
//  Created by Vinz on 6/16/25.
//

import Foundation

struct User: Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: Tags
    var friends: Friends
}
