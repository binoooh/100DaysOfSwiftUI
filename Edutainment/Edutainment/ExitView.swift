//
//  ExitView.swift
//  Edutainment
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI

struct ExitView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var gameManager = GameViewModel()
    
    var body: some View {
        Button {
            gameManager.isShowingGameView = false
            dismiss()
        } label: {
            Image(systemName: "xmark.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .padding()
        }
    }
}

#Preview {
    ExitView()
}
