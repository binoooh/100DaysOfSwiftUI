//
//  TipsData.swift
//  Habit Tracker
//
//  Created by Vinz on 5/29/25.
//

import SwiftUI

struct TipsModel: Identifiable {
    let id = UUID()
    let tag: String
    let image: String
    let description: String
    
    init(tag: String, image: String, description: String) {
        self.tag = tag
        self.image = image
        self.description = description
    }
    
}
