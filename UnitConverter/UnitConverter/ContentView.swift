//
//  ContentView.swift
//  UnitConverter
//
//  Created by @binoooh on 4/22/25.
//

import SwiftUI

extension UnitDuration {
    static let days = UnitDuration(symbol: "d", converter: UnitConverterLinear(coefficient: 86400))
    static let months = UnitDuration(symbol: "mo", converter: UnitConverterLinear(coefficient: 2629746))
    static let years = UnitDuration(symbol: "yr", converter: UnitConverterLinear(coefficient: 31_557_600))
}

struct ContentView: View {
    
    @State private var inputValue: Double = 0.0
    @State private var inputUnit: String = "Minutes"
    @State private var outputUnit: String = "Hours"
    
    let timeUnits = ["Seconds", "Minutes", "Hours", "Days", "Months", "Years"]

    var outputValue: Double {
        
        let measurement: Measurement<UnitDuration>
        // Cnvert Unit to Measurement
        switch inputUnit {
            case "Seconds":
                measurement = Measurement(value: inputValue, unit: .seconds)
            case "Minutes":
                measurement = Measurement(value: inputValue, unit: .minutes)
            case "Hours":
                measurement = Measurement(value: inputValue, unit: .hours)
            case "Days":
                measurement = Measurement(value: inputValue, unit: .days)
            case "Months":
                measurement = Measurement(value: inputValue, unit: .months)
            case "Years":
                measurement = Measurement(value: inputValue, unit: .years)
            default:
                measurement = Measurement(value: inputValue, unit: .seconds)
        }
        
        // Convert to output unit
        switch outputUnit {
            case "Seconds":
                return measurement.converted(to: .seconds).value
            case "Minutes":
                return measurement.converted(to: .minutes).value
            case "Hours":
                return measurement.converted(to: .hours).value
            case "Days":
                return measurement.converted(to: .days).value
            case "Months":
                return measurement.converted(to: .months).value
            case "Years":
                return measurement.converted(to: .years).value
            default:
                return measurement.converted(to: .seconds).value
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    TextField("Value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Enter a number")
                }
                
                Section {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    Text("\(outputValue.formatted()) \(outputUnit)")
                } header: {
                    Text("Converted Value")
                }
                
            }
            .navigationTitle("Time Converter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
