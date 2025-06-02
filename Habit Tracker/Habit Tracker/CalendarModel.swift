//
//  CalendarDay.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import Foundation

// Model for CalendarDay
struct CalendarModel: Identifiable, Hashable {
    let id = UUID()
    let dayNumber: Int
    let dayOfWeek: String
    var isSelected: Bool = false // To track selection
    var isFutureDay: Bool = false
}
