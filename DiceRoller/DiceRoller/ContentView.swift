//
//  ContentView.swift
//  DiceRoller
//
//  Created by bino on 7/13/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Environment property to access the SwiftData model context for saving/fetching data.
    @Environment(\.modelContext) private var modelContext

    // Query to fetch all DiceRoll objects from SwiftData, sorted by date descending.
    @Query(sort: \DiceRoll.date, order: .reverse) private var diceRolls: [DiceRoll]

    // State variables for user customization and displaying results.
    @State private var numberOfDice: Int = 1 // Default to 1 die
    @State private var diceType: Int = 6 // Default to d6
    @State private var currentRollTotal: Int = 0 // Stores the total of the most recent roll

    // Array of available dice types.
    let availableDiceTypes = [4, 6, 8, 10, 12, 20, 100] // Common dice types

    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Dice Customization Section
                // Allows users to select the number and type of dice.
                VStack(spacing: 20) {
                    Text("Customize Your Roll")
                        .font(.headline)
                        .padding(.bottom, 5)

                    HStack {
                        Text("Number of Dice:")
                        Spacer()
                        // Stepper to adjust the number of dice (1 to 10).
                        Stepper(value: $numberOfDice, in: 1...10) {
                            Text("\(numberOfDice)")
                        }
                    }
                    .padding(.horizontal)

                    HStack {
                        Text("Dice Type:")
                        Spacer()
                        // Picker to select the dice type (d4, d6, d8, etc.).
                        Picker("Dice Type", selection: $diceType) {
                            ForEach(availableDiceTypes, id: \.self) { type in
                                Text("Dice \(type)").tag(type)
                            }
                        }
                        .pickerStyle(.menu) // Segmented style for a clean look
                        .frame(width: 200) // Constrain picker width
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
                .shadow(radius: 5)

                Spacer()

                // MARK: - Roll Button
                // Button to trigger the dice roll.
                Button(action: rollDice) {
                    Label("Roll Dice!", systemImage: "die.face.5.fill") // System icon for dice
                        .font(.largeTitle)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.teal]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)

                // MARK: - Current Roll Result Display
                // Shows the total of the most recent dice roll.
                Text("Last Roll Total: \(currentRollTotal)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .animation(.easeInOut, value: currentRollTotal) // Smooth animation for total change

                Spacer()

                // MARK: - Past Rolls History
                // Displays a list of all previously saved dice rolls.
                List {
                    Section("Past Rolls") {
                        if diceRolls.isEmpty {
                            Text("No rolls yet. Roll some dice!")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(diceRolls) { roll in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Rolled \(roll.numberOfDice) of Dice \(roll.diceType)")
                                            .font(.headline)
                                        Text("Total: \(roll.totalResult)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Text(roll.date, format: .dateTime.hour().minute().second()) // Format date for display
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            // Allows deleting past rolls from the list.
                            .onDelete(perform: deleteItems)
                        }
                    }
                }
                .listStyle(.insetGrouped) // Modern list style
            }
            .navigationTitle("Dice Roller")
            // Add an edit button to the navigation bar for deleting items.
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }

    // MARK: - Dice Rolling Logic
    // This function simulates rolling the dice, calculates the total,
    // triggers haptic feedback, and saves the result.
    private func rollDice() {
        var total = 0
        for _ in 0..<numberOfDice {
            // Generate a random number between 1 and the diceType (inclusive).
            total += Int.random(in: 1...diceType)
        }
        currentRollTotal = total

        // Trigger haptic feedback for a physical sensation.
        // Use .impact(.medium) for a noticeable but not too strong feedback.
        HapticFeedback.impact(.medium)

        // Save the current roll to SwiftData.
        let newRoll = DiceRoll(numberOfDice: numberOfDice, diceType: diceType, totalResult: total)
        modelContext.insert(newRoll) // Add the new roll to the model context.

        // Note: SwiftData automatically saves changes when the model context is updated.
        // No explicit save() call is typically needed unless you want to force a save.
    }

    // MARK: - Delete Function for SwiftData
    // This function handles deleting selected dice roll entries from SwiftData.
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(diceRolls[index]) // Delete the item from the model context.
        }
        // Note: SwiftData automatically persists the deletion.
    }
}

// MARK: - Haptic Feedback Utility
// A simple utility struct to provide haptic feedback.
// This makes the haptic calls cleaner in the main view.
struct HapticFeedback {
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }

    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}

// MARK: - Preview Provider (for Xcode Canvas)
// Provides a preview of the ContentView in Xcode's canvas.
#Preview {
    ContentView()
        // Provide a temporary model container for the preview.
        // This allows the preview to display data even without a real device/simulator.
        .modelContainer(for: DiceRoll.self, inMemory: true)
}
