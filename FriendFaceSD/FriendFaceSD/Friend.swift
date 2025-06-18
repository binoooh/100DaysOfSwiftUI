//
//  Friends.swift
//  SocialNetwork
//
//  Created by Vinz on 6/16/25.
//

import Foundation
import SwiftData

@Model
class Friend {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
