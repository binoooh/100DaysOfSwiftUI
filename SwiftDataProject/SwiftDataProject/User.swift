//
//  User.swift
//  SwiftDataProject
//
//  Created by Vinz on 6/11/25.
//

import Foundation
import SwiftData

@Model
class User {
    var name:  String
    var city:  String
    var joinDate: Date
   // var jobs = [Job]()
    @Relationship(deleteRule: .cascade) var jobs = [Job]()
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
