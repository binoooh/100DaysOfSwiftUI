//
//  PersonalView.swift
//  iExpense
//
//  Created by @binoooh on 5/14/25.
//  Day 38 Code Challenge

import SwiftUI

struct PersonalView: View {
    
    var expenses: Expenses
    var expenseType = "Personal"
    
    var body: some View {
       
        List {
            Section(header: Text("Personal").font(.headline)) {
                ForEach(expenses.items) { item in
                    if item.type == expenseType {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: "\(item.currency)"))
                        }
                    }
                }
                .onDelete(perform: removePersonal)
            }
        }
        .listStyle(InsetGroupedListStyle()) // Optional: for a distinct look
    }
    
    func removePersonal(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    PersonalView(expenses: Expenses())
}
