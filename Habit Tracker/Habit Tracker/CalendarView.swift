//
//  CalendarView.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var days: [CalendarDay] = []
    @State private var selectedDayID: UUID?
    @State private var displayedDate: Date = Date()

    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()

    // Define "today" for comparison, ignoring time components for date checking.
    private var today: Date {
        calendar.startOfDay(for: Date())
    }

    init() {
        let initialDate = Date()
        // Pass `today` to `generateDaysInMonth` for accurate future day calculation
        let initialDays = generateDaysInMonth(for: initialDate, today: calendar.startOfDay(for: Date()), calendar: calendar, dateFormatter: dateFormatter)
        _days = State(initialValue: initialDays)
        _selectedDayID = State(initialValue: initialDays.first(where: { $0.isSelected })?.id)
        _displayedDate = State(initialValue: initialDate)
    }

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(days) { day in
                            DayView(day: day)
                                .id(day.id)
                                .onTapGesture {
                                    // Prevent selection if the day is in the future
                                    if day.isFutureDay {
                                        return
                                    }

                                    if selectedDayID != day.id {
                                        if let currentlySelected = selectedDayID,
                                           let currentIndex = days.firstIndex(where: { $0.id == currentlySelected }) {
                                            days[currentIndex].isSelected = false
                                        }
                                        
                                        if let tappedIndex = days.firstIndex(where: { $0.id == day.id }) {
                                            days[tappedIndex].isSelected = true
                                            selectedDayID = day.id
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .onAppear {
                    getCurrentDay(for: proxy)
                }
                .onChange(of: selectedDayID) {
                    checkFutureDay(for: selectedDayID, proxy: proxy)
                }
            }
        }
    }
    
    private func checkFutureDay(for newID: UUID?, proxy: ScrollViewProxy) {
        if let newID = newID {
            // Check if the day associated with newID is not a future day before scrolling
            if let dayToScroll = days.first(where: { $0.id == newID }), !dayToScroll.isFutureDay {
                withAnimation {
                    proxy.scrollTo(newID, anchor: .center)
                }
            }
        }
    }
    
    private func getCurrentDay(for proxy: ScrollViewProxy) {
        let currentDateOnAppear = Date()
        let startOfCurrentDateOnAppear = calendar.startOfDay(for: currentDateOnAppear)
        var needsScroll = false

        if !calendar.isDate(startOfCurrentDateOnAppear, equalTo: calendar.startOfDay(for: displayedDate), toGranularity: .month) ||
           !calendar.isDate(startOfCurrentDateOnAppear, equalTo: calendar.startOfDay(for: displayedDate), toGranularity: .year) {
            
            let newDays = generateDaysInMonth(for: startOfCurrentDateOnAppear, today: startOfCurrentDateOnAppear, calendar: calendar, dateFormatter: dateFormatter)
            self.days = newDays
            self.displayedDate = startOfCurrentDateOnAppear
            self.selectedDayID = newDays.first(where: { $0.isSelected })?.id
            needsScroll = true
            
        } else {
            // If the month is the same, check if 'today' has changed (e.g. app open overnight)
            // or if selection needs to be (re)applied.
            var daysNeedUpdate = false
            for index in days.indices {
                let dayDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: displayedDate),
                                                                month: calendar.component(.month, from: displayedDate),
                                                                day: days[index].dayNumber))!
                let isPastOrToday = calendar.startOfDay(for: dayDate) <= startOfCurrentDateOnAppear
                
                if days[index].isFutureDay == isPastOrToday { // if a future day is no longer future, or vice-versa
                    daysNeedUpdate = true
                    break
                }
                // check if 'isSelected' needs to be updated if today changed
                let shouldBeSelected = isTodayPredicate(dayComponent: days[index].dayNumber, dateBeingGenerated: dayDate, targetDate: startOfCurrentDateOnAppear, calendar: calendar)
                if days[index].isSelected != shouldBeSelected && !days[index].isFutureDay {
                    daysNeedUpdate = true
                    break
                }
            }

            if daysNeedUpdate {
                 let updatedDays = generateDaysInMonth(for: displayedDate, today: startOfCurrentDateOnAppear, calendar: calendar, dateFormatter: dateFormatter)
                 self.days = updatedDays
                 self.selectedDayID = updatedDays.first(where: { $0.isSelected })?.id
            }
            
            // Ensure selection if currently nil and today is selectable
            if selectedDayID == nil, let todayId = days.first(where: { $0.isSelected && !$0.isFutureDay })?.id {
                selectedDayID = todayId
            }
            needsScroll = true // Always attempt to scroll to selected day on appear
        }
        
        if needsScroll, let idToScroll = selectedDayID {
            DispatchQueue.main.async {
                withAnimation {
                    proxy.scrollTo(idToScroll, anchor: .center)
                }
            }
        }
    }

    private func generateDaysInMonth(for date: Date, today: Date, calendar: Calendar, dateFormatter: DateFormatter) -> [CalendarDay] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: date)?.count
        else {
            return []
        }

        var calendarDays: [CalendarDay] = []
        dateFormatter.dateFormat = "EEE"

        let startOfToday = calendar.startOfDay(for: today) // Use the passed 'today'

        for dayOffset in 0..<numberOfDaysInMonth {
            guard let dayDateInMonth = calendar.date(byAdding: .day, value: dayOffset, to: monthInterval.start) else {
                continue
            }
            
            let startOfDayInMonth = calendar.startOfDay(for: dayDateInMonth) // Compare start of days

            let dayNumber = calendar.component(.day, from: startOfDayInMonth)
            let dayOfWeek = dateFormatter.string(from: startOfDayInMonth)
            
            let isFuture = startOfDayInMonth > startOfToday
            // A day is selected if it's today AND it's not in the future (this check is a bit redundant if isFuture is false, but good for clarity)
            let isSelectedDay = calendar.isDate(startOfDayInMonth, inSameDayAs: startOfToday) && !isFuture
            
            calendarDays.append(CalendarDay(dayNumber: dayNumber, dayOfWeek: dayOfWeek, isSelected: isSelectedDay, isFutureDay: isFuture))
        }
        return calendarDays
    }
    
    private func isTodayPredicate(dayComponent: Int, dateBeingGenerated: Date, targetDate: Date, calendar: Calendar) -> Bool {
        // targetDate should already be startOfDay for consistent comparison
        let startOfDateBeingGenerated = calendar.startOfDay(for: dateBeingGenerated)
        return calendar.isDate(startOfDateBeingGenerated, inSameDayAs: targetDate)
    }

    private func monthYearString(from date: Date, dateFormatter: DateFormatter) -> String {
        dateFormatter.dateFormat = "MMMM YYYY"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    CalendarView()
}
