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
                Text("7 hrs 32 mins")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.bottom)
                
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
}

#Preview {
    HabitTrackerView(tag: "pray", title: "Pray for 10 mins")
}
