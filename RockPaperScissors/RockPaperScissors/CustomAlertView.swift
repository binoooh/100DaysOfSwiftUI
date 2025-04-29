//
//  CustomAlertView.swift
//  RockPaperScissors
//
//  Created by @binoooh on 4/28/25.
//

import SwiftUI

struct CustomAlertView: View {
    
    // Controls whether the alert is shown or hidden
    @Binding var isPresented: Bool
    
    // Content
    let title: String
    let message: String
    let buttonTitle: String
    
    // Customization
    var messageSize: CGFloat = 20
    var width: CGFloat = 300 // Default width
    var height: CGFloat = 180 // Default height
    var backgroundColor: Color = Color(.systemBackground) // Default background
    var cornerRadius: CGFloat = 15
    var shadowRadius: CGFloat = 10
    
    // Action to perform when the button is tapped
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            // Title Text
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            // Message Text
            Text(message)
                .font(.system(size: messageSize))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal) // Add some horizontal padding for longer messages
            
            Divider() // Separator
            
            // Action Button
            Button {
                // Perform the custom action first
                action()
                // Then dismiss the alert
                withAnimation {
                    isPresented = false
                }
            } label: {
                Text(buttonTitle)
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity) // Make button width flexible
            }
            .padding(.vertical, 8) // Add some padding to the button text
        }
        .padding() // Add padding inside the VStack
        .frame(width: width, height: height)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .shadow(radius: shadowRadius)
        .transition(.scale.combined(with: .opacity)) // Add appearance animation
        
    }
    
}

// Optional: Preview Provider for easy testing in Xcode Canvas
struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        // Use .constant(true) to show the alert in the preview
        CustomAlertView(
            isPresented: .constant(true),
            title: "Alert Title",
            message: "This is a detailed message explaining the alert's purpose.",
            buttonTitle: "OK",
            action: {
                print("Preview OK button tapped")
            }
        )
        .padding() // Add padding around the preview
        .previewLayout(.sizeThatFits) // Adjust preview layout

        // Preview with different colors/sizes
        CustomAlertView(
            isPresented: .constant(true),
            title: "Custom Look",
            message: "Different background and size.",
            buttonTitle: "Got it",
            width: 250,
            height: 200,
            backgroundColor: .blue.opacity(0.2),
            action: { }
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
