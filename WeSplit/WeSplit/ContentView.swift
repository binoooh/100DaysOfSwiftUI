//
//  ContentView.swift
//  WeSplit
//
//  Created by Arvn Dacumos on 4/21/25.
//

import SwiftUI

struct ContentView: View {
    let casts: [String] = ["Harry", "Hermoine", "Ron"]
    // @State marks a property as a source of truth for a view’s state.
    // When the property’s value changes, SwiftUI invalidates the view
    // and triggers a re-render to reflect the updated state.
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    
    // Closure to calculate the amount of tip per person
    var totalPerPeson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Enter the amount") {
                    // The $ prefix transforms a @State property into a Binding<Type>
                    // that can be passed to child views or SwiftUI components.
                    // A binding allows the child view or component to both read and modify the state,
                    // keeping the UI in sync with the state.
                    
                    // Many SwiftUI controls, like TextField, Toggle, or Slider,
                    // require a Binding to update their values and reflect user interactions.
                    // The $ sign provides this binding, ensuring changes in the control update the
                    // @State property, triggering a view re-render.
                    
                    // The TextField below requires a Binding<String>, provided by $checkAmount
                    // Locale.current.currency is used to retrieve the currency code for the user’s current locale
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section("Select the number of people") {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Select a tip", selection: $tipPercentage) {
                        // The id parameter in ForEach specifies how to uniquely identify each element.
                        // Using \.self can only be used when the collection's elements are themselves unique
                        // Use \.self to tell SwiftUI to use the element itself as its own identifier.
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
                        ForEach(0..<101) {
                            Text("\($0) %")
                        }
                    }
                    .pickerStyle(.navigationLink) // .pickerStyle(.segmented)
                }
                
                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .black) // Project 3 - Challenge 1
                } header: {
                    Text("Total Amount")
                }
                
                Section() {
                    Text(totalPerPeson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
