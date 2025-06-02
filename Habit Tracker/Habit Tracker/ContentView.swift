//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name: String = "Teri"
    
    // Adjust this value to control the overlap
    let overlapAmount: CGFloat = 150
    let cardData: [CardModel] = [
//        CardModel(title: "Sleep for 8 hours", tag: "sleep", detail: "Everyday", backgroundColor: Color(hex: 0xd8fe74), customGraphic: AnyView(SleepGraphic())),
        CardModel(title: "Go for a walk", tag: "walk", time: 25, detail: "25 min", backgroundColor: Color(hex: 0xf097e0), customGraphic: AnyView(WalkGraphic())),
        CardModel(title: "Meditate", tag: "meditate", time: 15, detail: "15 min", backgroundColor: Color(hex: 0x94abfe), customGraphic: AnyView(MeditateGraphic())),
        CardModel(title: "Pray", tag: "pray", time: 10, detail: "10 min", backgroundColor: Color(hex: 0xd8fe74), customGraphic: AnyView(PrayGraphic())),
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                CalendarView()
                VStack { // Use ScrollView if cards might exceed screen height
                    ZStack(alignment: .top){
                        ForEach(Array(cardData.enumerated()), id: \.element.id) { index, cardInfo in
                            CardView(info: cardInfo)
                                .offset(y: CGFloat(index) * overlapAmount)
                                .zIndex(Double(cardData.count))
                        }
                    }
                    .padding(.top, 20)
                }
                Spacer()
            }
            .navigationTitle("Good Morning, \(name)")
            .padding(.vertical)
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
