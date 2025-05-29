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
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text(tag)
            }
            .navigationTitle(tag)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        
    }
}

#Preview {
    HabitTrackerView(tag: "sleep")
}
