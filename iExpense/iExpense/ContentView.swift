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
            VStack {
                //  Day 38 Code Challenge
                PersonalView(expenses: expenses)
                BusinessView(expenses: expenses)
                Spacer() // Pushes the lists to the top if there's extra space
            }
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                // Day 46 Coding Challenge
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
