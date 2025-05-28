//
//  CardView.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import SwiftUI

struct CardView: View {
    
    let info: CardInfo
    let cardCornerRadius: CGFloat = 20 // Define corner radius
    let cardBottomWidthRatio: CGFloat = 0.90 // Example: Bottom is 95% of top width
    
    // State variable to control the wiggle animation
    @State private var wiggleCount: Int = 0
    @State private var offset: CGSize = .zero
    @State private var isCardPicked = false
    
    var body: some View {
        ZStack {
            RoundedTrapezoid(cornerRadius: cardCornerRadius, bottomWidthRatio: cardBottomWidthRatio)
                .fill(info.backgroundColor)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    Text(info.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black.opacity(0.8))
                    Spacer()
                    Text(info.detail)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black.opacity(0.7))
                }
                .padding(.horizontal)
                .padding(.top)
                
                Spacer()
                
                // Display custom graphic
                if let customGraphic = info.customGraphic {
                    customGraphic
                        .frame(width: 80, height: 80) // Adjust size as needed
                        .padding(.bottom)
                } else if let iconName = info.iconName {
                    if iconName == "Zzz" { // Special case for "Zzz" text
                        Text("Zzz")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.black.opacity(0.6))
                            .rotationEffect(.degrees(-15))
                            .offset(x: -30, y: -10) // Adjust positioning
                    } else {
                        Image(systemName: iconName) // using SF Symbols
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.black.opacity(0.7))
                            .padding(.bottom)
                    }
                }
                Spacer()
            }
        }
        .frame(height: 320) // Adjust height
        .padding(.horizontal)
        .rotationEffect(rotationAngleForWiggle(wiggleCount)) // Apply rotation based on wiggleCount
        // Animation applied when 'wiggleCount' changes
        .animation(.spring(response: 0.3, dampingFraction: 0.45), value: wiggleCount)
        .offset(offset)
        .onTapGesture {
            wiggleAnimation()
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    
                    wiggleAnimation()
                    
                    withAnimation(.bouncy) {
                        offset.height = UIScreen.main.bounds.height / value.translation.height - 30
                    }
                }
                .onEnded { value in
                    offset = .zero
                    isCardPicked.toggle()
                }
        )
        .fullScreenCover(isPresented: $isCardPicked) {
            HabitTrackerView(tag: info.tag)
        }
    }
    
    func rotationAngleForWiggle(_ count: Int) -> Angle {
        let maxAngle: CGFloat = 3.0 // Max degrees for the wiggle
        switch count {
        case 1: return .degrees(maxAngle)           // First wiggle right
        case 2: return .degrees(-maxAngle)          // First wiggle left
        case 3: return .degrees(maxAngle * 0.6)   // Second wiggle right (smaller)
        case 4: return .degrees(-maxAngle * 0.6)  // Second wiggle left (smaller)
        default: return .degrees(0)                 // Return to center
        }
    }
    
    func wiggleAnimation() {
        // Only start a new wiggle if not already wiggling
        guard wiggleCount == 0 else { return }
        
        let baseDelay: Double = 0.09 // Duration/delay for each step of the wiggle
        
        // Sequence the wiggle
        // Step 1: Rotate right
        wiggleCount = 1
        // Step 2: Rotate left
        DispatchQueue.main.asyncAfter(deadline: .now() + baseDelay) {
            wiggleCount = 2
        }
        // Step 3: Rotate right (smaller)
        DispatchQueue.main.asyncAfter(deadline: .now() + baseDelay * 2) {
            wiggleCount = 3
        }
        // Step 4: Rotate left (smaller)
        DispatchQueue.main.asyncAfter(deadline: .now() + baseDelay * 3) {
            wiggleCount = 4
        }
        // Step 5: Return to center
        DispatchQueue.main.asyncAfter(deadline: .now() + baseDelay * 4) {
            wiggleCount = 0
        }
    }
}

#Preview {
    CardView(info: CardInfo(title: "Sleep for 8 hours", tag: "sleep", detail: "Everyday", backgroundColor: Color(hex: 0xf097e0), customGraphic: AnyView(SleepGraphic())))
}
