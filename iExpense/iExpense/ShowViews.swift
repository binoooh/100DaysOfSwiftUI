//
//  ShowViews.swift
//  iExpense
//
//  Created by @binoooh on 5/10/25.
//

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    var body: some View {
        VStack {
            Text("Follow me \(name)")
                .padding()
            Button("Dismiss") {
                dismiss()
            }
        }
        
    }
}

import SwiftUI

struct ShowViews: View {
    
    @State private var isShowingSheet = false
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .padding()
            Button("Show Sheet") {
                isShowingSheet.toggle()
            }
            .sheet(isPresented: $isShowingSheet) {
                SecondView(name: "@bino")
            }
        }
    }
}

#Preview {
    ShowViews()
}
