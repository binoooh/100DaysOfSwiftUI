//
//  CardIno.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import SwiftUI

struct CardInfo: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let backGroundColor: Color
    let iconName: String?           // for SF symbols
    let customGraphic: AnyView?     // For complex graphics
    
    // Example initializer for cards with system icons
    init(title: String, detail: String, backGroundColor: Color, iconName: String) {
        self.title = title
        self.detail = detail
        self.backGroundColor = backGroundColor
        self.iconName = iconName
        self.customGraphic = nil
    }
    
    // Example initializer for cards with custom graphics
    init(title: String, detail: String, backGroundColor: Color, customGraphic: AnyView) {
        self.title = title
        self.detail = detail
        self.backGroundColor = backGroundColor
        self.iconName = nil
        self.customGraphic = customGraphic
    }
}
