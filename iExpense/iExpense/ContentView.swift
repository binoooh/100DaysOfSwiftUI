//
//  ContentView.swift
//  iExpense
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI
import SwiftData // Day 59 Coding Challenge

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext // Day 59 Coding Challenge
    
    @State private var isShowingAddNew = false
    @State private var expenseType = "Business"
    
    enum expenseTypes: String, CaseIterable {
        case business = "Business"
        case personal = "Personal"
    }
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.type),
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount),
    ]
    
    var body: some View {
        NavigationStack {
            // Day 59 Coding Challenge
            List {
                Picker("Expense Type", selection: $expenseType) {
                    ForEach(expenseTypes.allCases.reversed(), id: \.self) { type in
                        // expenseType is assinged with type.rawvalue
                        Text(type.rawValue)
                            .tag(type.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .listRowBackground(Color.clear)
                
                Section {
                    ExpenseView(expenseType: expenseType, sortOder: sortOrder) // Day 59 Coding Challenge
                }
            }
//            VStack {
//                //  Day 59 Code Challenge
//                PersonalView(expenseType: "Personal", sortOder: sortOrder) // Day 59 Coding Challenge
//                BusinessView(expenseType: "Business", sortOder: sortOrder) // Day 59 Coding Challenge
//                Spacer() // Pushes the lists to the top if there's extra space
//            }
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                // Day 46 Coding Challenge
                NavigationLink {
                    AddView() // Day 59 Coding Challenge
                } label: {
                    Image(systemName: "plus")
                }
                // Day 59 Coding Challenge
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Type and Amount")
                            .tag([
                                SortDescriptor(\ExpenseItem.type),
                                SortDescriptor(\ExpenseItem.amount),
                            ])
                        Text("Sort by Type and Name")
                            .tag([
                                SortDescriptor(\ExpenseItem.type),
                                SortDescriptor(\ExpenseItem.name),
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
