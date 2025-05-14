//
//  AddView.swift
//  iExpense
//
//  Created by @binoooh on 5/12/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount: Double = 0.0
    @State private var currency = "USD"
    // Day 38 Coding Challenge
    let currencies = ["USD", "CAD", "JPY", "EUR", "AUD"]
    var expenses: Expenses

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                
                Section(header: Text("Type")) {
                    Picker("Type", selection: $type) {
                        Text("Personal").tag("Personal")
                        Text("Business").tag("Business")
                    }
                }
                Section(header: Text("Amount")) {
                    // Day 38 - Coding Challenge
                    HStack {
                        TextField("Amount", value: $amount, format: .number.grouping(.automatic).precision(.fractionLength(2)))
                            .keyboardType(.decimalPad)
                        // Day 38 Coding Challenge
                        Picker("Currency", selection: $currency) {
                            ForEach(currencies, id: \.self) { cur in
                                Text(cur).tag(cur)
                            }
                        }
                        .labelsHidden()
                    }
                }
            }
            .navigationTitle("Add New Item")
            .toolbar {
                Button("Save") {
                    // Day 38 Coding Challenge
                    let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
