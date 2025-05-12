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
    @State private var type = "Pesonal"
    @State private var amount: Double = 0.0
    
    var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                
                Section(header: Text("Type")) {
                    Picker("Type", selection: $type) {
                        Text("Pesonal").tag("Pesonal")
                        Text("Business").tag("Business")
                    }
                }
                Section(header: Text("Amount")) {
                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                    
                }
            }
            .navigationTitle("Add New Item")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
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
