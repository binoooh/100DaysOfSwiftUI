//
//  PersonalView.swift
//  iExpense
//
//  Created by @binoooh on 5/14/25.
//  Day 38 Code Challenge

import SwiftUI
import SwiftData

struct PersonalView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var expenses: [ExpenseItem]
    //var expenses: Expenses
    var expenseType = "Personal"
    
    var body: some View {
        List {
            Section(header: Text("Personal").font(.headline)) {
                ForEach(expenses) { expense in
                    if expense.type == expenseType {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expense.name)
                                    .font(.headline)
                                Text(expense.type)
                            }
                            Spacer()
                            Text(expense.amount, format: .currency(code: "\(expense.currency)"))
                        }
                    }
                }
                .onDelete(perform: removePersonal)
            }
        }
        .listStyle(InsetGroupedListStyle()) // Optional: for a distinct look
    }
    
    init(expenseType: String, sortOder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(filter: #Predicate<ExpenseItem> { expense in
            expense.type == expenseType
        }, sort: sortOder)
    }
    
    func removePersonal(at offsets: IndexSet) {
        //expenses.items.remove(atOffsets: offsets)
        // Day 59 Coding Challenge
        withAnimation {
            for index in offsets {
                modelContext.delete(expenses[index])
            }
        }
    }
}

#Preview {
    PersonalView(expenseType: "Personal", sortOder: [SortDescriptor(\ExpenseItem.type)])
        .modelContainer(for: ExpenseItem.self)
}
