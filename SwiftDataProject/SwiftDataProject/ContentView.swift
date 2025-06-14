//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Vinz on 6/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var isShowingUpcomingOnly = false
    
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]
    
    var body: some View {
        NavigationStack {
            UsersView(minimumJoinDate: isShowingUpcomingOnly ? .now : .distantPast, sortOder: sortOrder)
            .navigationTitle("Users")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)
                    let first = User(name: "Leo", city: "Whitby", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Kumar", city: "Belleville", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Andrew", city: "Ajax", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Param", city: "Durham", joinDate: .now.addingTimeInterval(86400 * 10))
                    
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                    
                }
                
                Button(isShowingUpcomingOnly ? "Show Everyone" : "Show Upcoming Only") {
                    isShowingUpcomingOnly.toggle()
                }
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate),
                            ])
                        Text("Soft by Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name),
                            ])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
