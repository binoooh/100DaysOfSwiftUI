//
//  ContentView.swift
//  BetterRest
//
//  Created by @binoooh on 4/30/25.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationStack {
            
            HStack { // Day 28 Challenge
                Text("BetterRest")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "moon.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            .padding(.all, 30)
            
            Form {
                
                Section { // Day 28 Challenge
                    HStack {
                        Image(systemName: "clock").foregroundStyle(.blue)
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                } header: {
                    Text("When do you want to wake up?")
                        .font(.subheadline.bold())
                        .foregroundStyle(.blue)
                        .textCase(nil)
                }
                Section { // Day 28 Challenge
                    HStack {
                        Image(systemName: "bed.double.fill").foregroundStyle(.blue)
                        Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                } header: {
                    Text("Desired amount of sleep")
                        .font(.subheadline.bold())
                        .foregroundStyle(.blue)
                        .textCase(nil)
                }
                
                Section { // Day 28 Challenge
                    HStack {
                        Image(systemName: "cup.and.saucer").foregroundStyle(.blue)
                        Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                            ForEach(0...20, id: \.self) {
                                Text("^[\($0) cup](inflect: true)")
                            }
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                        .font(.subheadline.bold())
                        .foregroundStyle(.blue)
                        .textCase(nil)
                }
                
                Section { // Day 28 Challenge
                    VStack {
                        Text("Recommended Bedtime")
                            .foregroundStyle(.blue)
                        Text(calculateBedTime())
                            .font(.title2.bold())
                            .padding(5)
                    }
                    .padding(15)
                }
                .frame(maxWidth: .infinity)
                
            }
        }
        
    }
    
    func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration() // reads our SleepCalculator ML data
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            return "Error"
            
        }
    }
}

#Preview {
    ContentView()
    
}
