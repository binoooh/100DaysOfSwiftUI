//
//  User.swift
//  SocialNetwork
//
//  Created by Vinz on 6/16/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date // Decoded as a Date object
    let tags: [String] // Decoded as an array of Strings
    let friends: [Friend] // Decoded as an array of Friend objects
}
