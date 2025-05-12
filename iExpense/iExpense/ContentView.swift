//
//  ContentView.swift
//  iExpense
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI


struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var isShowingAddNew = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add new item", systemImage: "plus") {
                    isShowingAddNew = true
                }
            }
            .sheet(isPresented: $isShowingAddNew) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
