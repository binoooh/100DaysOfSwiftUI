//
//  ExpenseView.swift
//  iExpense
//
//  Created by Vinz on 6/14/25.
//

import SwiftUI
import SwiftData

struct ExpenseView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var expenses: [ExpenseItem]
    
    var body: some View {
        ForEach(expenses) { expense in
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
        .onDelete(perform: removeExpense)
    }
    
    init(expenseType: String, sortOder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(filter: #Predicate<ExpenseItem> { expense in
            expense.type == expenseType
        }, sort: sortOder)
    }
    
    func removeExpense(at offsets: IndexSet) {
        // Day 59 Coding Challenge
        withAnimation {
            for index in offsets {
                modelContext.delete(expenses[index])
            }
        }
    }
}

#Preview {
    ExpenseView(expenseType: "Personal", sortOder: [SortDescriptor(\ExpenseItem.type)])
        .modelContainer(for: ExpenseItem.self)
}
