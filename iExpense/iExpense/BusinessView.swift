//
//  BusinessView.swift
//  iExpense
//
//  Created by @binoooh on 5/14/25.
//  Day 38 Code Challenge

import SwiftUI

struct BusinessView: View {
    
    var expenses: Expenses
    var expenseType = "Business"
    
    var body: some View {
        List {
            Section(header: Text("Business").font(.headline)) {
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
                .onDelete(perform: removeBusiness)
            }
        }
        .listStyle(InsetGroupedListStyle()) // Optional: for a distinct look
    }
    
    func removeBusiness(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    BusinessView(expenses: Expenses())
}
