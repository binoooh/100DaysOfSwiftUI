//
//  SleepView.swift
//  Habit Tracker
//
//  Created by Vinz on 5/29/25.
//

import SwiftUI

struct HabitTrackerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let tag: String
    let title: String
    let time: Int
    
    let allTips: [TipsModel] = [
        TipsModel(tag: "sleep", image: "drop", description: "Drink some water before going to bed"),
        TipsModel(tag: "sleep", image: "headphones", description: "Listen to relaxing music before sleeping"),
        TipsModel(tag: "sleep", image: "book", description: "Read your favorite book before sleeping"),
        
        TipsModel(tag: "walk", image: "drop.halffull", description: "Bring a bottle of water with you"),
        TipsModel(tag: "walk", image: "clock", description: "If you start to feel tired, take a break"),
        TipsModel(tag: "walk", image: "thermometer.medium", description: "Dress warmly, it's cold outside"),
        
        TipsModel(tag: "meditate", image: "ear", description: "Find a quiet place before you start"),
        TipsModel(tag: "meditate", image: "earpods", description: "Listen to ambient music to relax"),
        TipsModel(tag: "meditate", image: "chair.lounge", description: "Find a comfy chair to sit and relax"),
        
        TipsModel(tag: "pray", image: "house", description: "Find a quiet place before you start"),
        TipsModel(tag: "pray", image: "book.closed", description: "Read a Bible passage before praying"),
        TipsModel(tag: "pray", image: "lightbulb", description: "Dim the lights to set the mood")
    ]
    
    @State private var selectedTag: String = ""
   
    // The text displayed on the button.
    @State private var buttonText: String = "Start"
    // The total time remaining in seconds.
    @State private var timeRemaining: Int = 0
    // The current timer instance.
    @State private var timer: Timer?
    // Tracks whether the timer is currently active.
    @State private var isTimerRunning: Bool = false
    
    var filteredTips: [TipsModel] {
        if selectedTag.isEmpty {
            return []
        }
        return allTips.filter { $0.tag == selectedTag }
    }
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                Image(getImage(tag: tag))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .shadow(radius: 10)
                
                // TODO: Add Timer
                Button {
                    //
                    toggleTimer()
                } label: {
                    Text(buttonText)
                        .font(.system(size: 32, weight: .bold))
                        .fontDesign(.rounded)
                        .foregroundStyle(.black)
                        .padding(.bottom)
                        
                }
                .disabled(isTimerRunning)
                
                HStack {
                    Text("Try some tips")
                        .font(.system(size: 24, weight: .medium))
                    Spacer()
                }
                .padding([.horizontal, .bottom])
                
                ForEach(filteredTips) { tip in
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: UIScreen.main.bounds.width / 1.1, height: 60)
                        HStack {
                            Image(systemName: tip.image)
                                .font(.system(size: 20, weight: .light))
                            Text(tip.description)
                                .lineLimit(1, reservesSpace: true)
                                .font(.system(size: 16, weight: .light))
                                .foregroundStyle(.black)
                                .minimumScaleFactor(0.8)
                                .lineLimit(1)
                                .fixedSize(horizontal: true, vertical: true)
                        }
                    }
                    
                }
                // Finish button
                Button {
                    dismiss()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black.opacity(0.9))
                            .frame(width: UIScreen.main.bounds.width / 1.1, height: 60)
                        Text("Finish")
                            .font(.system(size: 22, weight: .regular))
                            .foregroundStyle(.white)
                    }
                }
                .disabled(isTimerRunning)
                .padding(.top)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.title)
                            .foregroundStyle(.black)
                            .frame(width: 32, height: 32)
                            .shadow(radius: 20)
                            .padding()
                    }
                }
            }
            .onAppear {
                self.selectedTag = tag
            }
        }
    }
    
    func getImage(tag: String) -> ImageResource {
        
        let imageTag: ImageResource
        
        if tag == "sleep" {
            imageTag = .sleep
        } else if tag == "walk" {
            imageTag = .walk
        } else if tag == "meditate" {
            imageTag = .meditate
        } else {
            imageTag = .pray
        }
        
        return imageTag
    }
    // MARK: - Timer Logic

        private func toggleTimer() {
            if isTimerRunning {
                // If timer is running, tapping again might be intended to stop/reset.
                // For this request, we'll let it run its course or reset it immediately.
                // Let's choose to reset it.
                stopTimer()
                buttonText = "Start"
                // Reset timeRemaining to the full duration when stopping
                timeRemaining = time * 60
            } else {
                // If timer is not running, start it.
                startTimer()
            }
        }

        private func startTimer() {
            isTimerRunning = true
            timeRemaining = time * 60
            updateButtonText() // Show initial time

            // Invalidate any existing timer before starting a new one.
            timer?.invalidate()

            // Create a new timer that fires every second.
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    updateButtonText()
                } else {
                    // Timer has finished.
                    stopTimer()
                    buttonText = "Start"
                }
            }
        }

        private func stopTimer() {
            // Invalidate and release the timer.
            timer?.invalidate()
            timer = nil
            isTimerRunning = false
        }

        private func updateButtonText() {
            // Format the remaining time as "MM:SS".
            let minutes = timeRemaining / 60
            let seconds = timeRemaining % 60
            buttonText = String(format: "%02d:%02d", minutes, seconds)
        }
}

#Preview {
    HabitTrackerView(tag: "pray", title: "Pray for 10 mins", time: 1)
}
