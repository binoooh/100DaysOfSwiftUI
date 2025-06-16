//
//  AddView.swift
//  iExpense
//
//  Created by @binoooh on 5/12/25.
//

import SwiftUI
import SwiftData // Day 59 Coding Challenge

struct AddView: View {
    @Environment(\.modelContext) var modelContext // Day 59 Coding Challenge
    @Environment(\.dismiss) var dismiss
    @State private var name = "Add New Item"
    @State private var type = "Personal"
    @State private var amount: Double = 0.0
    @State private var currency = "USD"
    // Day 38 Coding Challenge
    let currencies = ["USD", "CAD", "JPY", "EUR", "AUD"]
    @Query var expenses: [ExpenseItem]

    var body: some View {
        NavigationStack {
            Form {
                // Day 46 Coding Challenge
                //Section(header: Text("Name")) {
                //    TextField("Name", text: $name)
                //}
                
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
            // Day 46 Coding Challenge
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Day 46 Coding Challenge
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                // Day 46 Coding Challenge
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        
                        // Day 38 Coding Challenge
                        //let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                        //expenses.items.append(item)
                        
                        // Day 59 Coding Challenge
                        let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                        modelContext.insert(item)
                        dismiss()
                    }
                }
            }
            // Day 46 Coding Challenge
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddView() // Day 59 Coding Challenge
}
