//
//  CalendarView.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var days: [CalendarModel] = []
    @State private var selectedDayID: UUID?
    @State private var displayedDate: Date = Date()

    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()

    // Define "today" for comparison, ignoring time components for date checking.
    private var today: Date {
        calendar.startOfDay(for: Date())
    }

    init() {
        let initialDisplayDate = Date()
        let initialDays = generateDaysInMonth(for: initialDisplayDate, actualTodayDate: self.today, calendar: calendar, dateFormatter: dateFormatter)
        _days = State(initialValue: initialDays)
        _selectedDayID = State(initialValue: initialDays.first(where: { $0.isSelected })?.id)
        _displayedDate = State(initialValue: calendar.startOfDay(for: initialDisplayDate))
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
        if let currentID = newID {
            if let dayToScroll = days.first(where: { $0.id == currentID }), !dayToScroll.isFutureDay {
                withAnimation {
                    proxy.scrollTo(currentID, anchor: .center)
                }
            }
        }
    }
    
    private func getCurrentDay(for proxy: ScrollViewProxy) {
        let currentActualDate = self.today // Current start of day
        
        // Check if the displayed month/year is different from the current actual month/year
        if !calendar.isDate(displayedDate, equalTo: currentActualDate, toGranularity: .month) ||
            !calendar.isDate(displayedDate, equalTo: currentActualDate, toGranularity: .year) {
            
            // Month or year has changed, regenerate days for the new current month
            let newDays = generateDaysInMonth(
                for: currentActualDate, // Generate for the current month
                actualTodayDate: currentActualDate, // Use current date for "today" status
                calendar: calendar,
                dateFormatter: dateFormatter
            )
            self.days = newDays
            self.displayedDate = currentActualDate // Update displayedDate to the new month
            self.selectedDayID = newDays.first(where: { $0.isSelected })?.id
            
        } else {
            // Month and year are the same. Update isFutureDay and isSelected for existing days.
            var newPotentialSelectedID: UUID? = nil
            var modelsActuallyChanged = false
            
            for i in days.indices {
                let originalDayIsSelected = days[i].isSelected
                let originalDayIsFuture = days[i].isFutureDay
                
                // Construct the date for the current item in the loop
                // Use displayedDate for year/month context as we are in the "same month" block
                guard let dayDate = calendar.date(from: DateComponents(
                    year: calendar.component(.year, from: displayedDate),
                    month: calendar.component(.month, from: displayedDate),
                    day: days[i].dayNumber))
                else { continue }
                
                let startOfDayItem = calendar.startOfDay(for: dayDate)
                let newIsFutureDay = startOfDayItem > currentActualDate
                let newIsSelectedDay = calendar.isDate(startOfDayItem, inSameDayAs: currentActualDate) && !newIsFutureDay
                
                if originalDayIsFuture != newIsFutureDay || originalDayIsSelected != newIsSelectedDay {
                    days[i].isFutureDay = newIsFutureDay
                    days[i].isSelected = newIsSelectedDay
                    modelsActuallyChanged = true
                }
                
                if newIsSelectedDay {
                    newPotentialSelectedID = days[i].id
                }
            }
            
            // Update selectedDayID if it has changed based on the refreshed isSelected states
            if self.selectedDayID != newPotentialSelectedID {
                self.selectedDayID = newPotentialSelectedID
            } else if modelsActuallyChanged && newPotentialSelectedID == nil && self.selectedDayID != nil {
                // If models changed, nothing is newly selected, but something *was* selected, nullify it.
                // This handles the case where 'today' moves and the previously selected day is no longer 'today'.
                self.selectedDayID = nil
            } else if modelsActuallyChanged && newPotentialSelectedID != nil && self.selectedDayID == nil {
                // If models changed, something is newly selected, and nothing *was* selected, set it.
                self.selectedDayID = newPotentialSelectedID
            }
        }
        
        // Scroll to the selected day if it exists and is not a future day
        // This will use the potentially updated selectedDayID
        if let idToScroll = selectedDayID,
           let dayToScroll = days.first(where: { $0.id == idToScroll }),
           !dayToScroll.isFutureDay {
            DispatchQueue.main.async { // Ensure UI updates on main thread
                withAnimation {
                    proxy.scrollTo(idToScroll, anchor: .center)
                }
            }
        }
    }

    private func generateDaysInMonth(for generatingMonthDate: Date, actualTodayDate: Date, calendar: Calendar, dateFormatter: DateFormatter) -> [CalendarModel] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: generatingMonthDate),
              let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: generatingMonthDate)?.count
        else {
            return []
        }
        
        var calendarDays: [CalendarModel] = []
        dateFormatter.dateFormat = "EEE" // Set date format for day of week
        
        let startOfActualToday = calendar.startOfDay(for: actualTodayDate) // Use the passed actual today date
        
        for dayOffset in 0..<numberOfDaysInMonth {
            guard let dayDateInMonth = calendar.date(byAdding: .day, value: dayOffset, to: monthInterval.start) else {
                continue
            }
            
            let startOfDayInMonth = calendar.startOfDay(for: dayDateInMonth)
            
            let dayNumber = calendar.component(.day, from: startOfDayInMonth)
            let dayOfWeek = dateFormatter.string(from: startOfDayInMonth)
            
            let isFuture = startOfDayInMonth > startOfActualToday
            // A day is selected if it matches the actualTodayDate AND it's not in the future
            let isSelectedDay = calendar.isDate(startOfDayInMonth, inSameDayAs: startOfActualToday) && !isFuture
            
            calendarDays.append(CalendarModel(dayNumber: dayNumber, dayOfWeek: dayOfWeek, isSelected: isSelectedDay, isFutureDay: isFuture))
        }
        return calendarDays
    }
    
    // This function can be used to display the current month and year, e.g., above the calendar
    private func monthYearString(from date: Date, dateFormatter: DateFormatter) -> String {
        dateFormatter.dateFormat = "MMMM yyyy" // Format for month and year
        return dateFormatter.string(from: date)
    }
}

#Preview {
    CalendarView()
}
