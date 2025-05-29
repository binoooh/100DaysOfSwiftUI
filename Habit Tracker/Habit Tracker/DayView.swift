//
//  DayView.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

struct DayView: View {
    
    let day: CalendarModel
    
    var body: some View {
        VStack(spacing: 4) {
            Text("\(day.dayNumber)")
                .font(.headline)
                .fontWeight(.bold)
            Text(day.dayOfWeek)
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 10)
        .frame(width: 60, height: 70)
        .background(backgroundColor)
        .foregroundStyle(foregroundColor)
        .cornerRadius(12)
    }
    
    // Computed property for background color
    private var backgroundColor: Color {
        if day.isFutureDay {
            return Color(white: 0.9) // Light gray for future days
        }
        return day.isSelected ? Color(hex: 0x1b1b1b) : Color(hex: 0xd8fe74) //
    }
    
    // Computed property for foreground color
    private var foregroundColor: Color {
        if day.isFutureDay { //
            return Color(white: 0.6) // Slightly darker gray text for future days for readability
        }
        return day.isSelected ? .white : .black //
    }
}

#Preview {
    VStack {
            DayView(day: CalendarModel(dayNumber: 21, dayOfWeek: "Mon", isSelected: false))
            DayView(day: CalendarModel(dayNumber: 22, dayOfWeek: "Tue", isSelected: true))
            DayView(day: CalendarModel(dayNumber: 23, dayOfWeek: "Wed", isSelected: false, isFutureDay: true)) //
            DayView(day: CalendarModel(dayNumber: 24, dayOfWeek: "Thu", isSelected: true, isFutureDay: true)) // Example of a selected future day (though our logic prevents this state)
        }
}
