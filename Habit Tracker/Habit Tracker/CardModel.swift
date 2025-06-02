//
//  CardInfo.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import SwiftUI

struct CardModel: Identifiable {
    let id = UUID()
    let tag: String
    let time: Int
    let title: String
    let detail: String
    let backgroundColor: Color
    let iconName: String?           // for SF symbols
    let customGraphic: AnyView?     // For complex graphics
    
    // Example initializer for cards with system icons
    init(title: String, tag: String, time: Int, detail: String, backgroundColor: Color, iconName: String) {
        self.title = title
        self.tag = tag
        self.time = time
        self.detail = detail
        self.backgroundColor = backgroundColor
        self.iconName = iconName
        self.customGraphic = nil
    }
    
    // Example initializer for cards with custom graphics
    init(title: String, tag: String, time: Int, detail: String, backgroundColor: Color, customGraphic: AnyView) {
        self.title = title
        self.tag = tag
        self.time = time
        self.detail = detail
        self.backgroundColor = backgroundColor
        self.iconName = nil
        self.customGraphic = customGraphic
    }
}
