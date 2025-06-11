//
//  MultiLineTextView.swift
//  Bookworm
//
//  Created by Vinz on 6/4/25.
//

import SwiftUI

struct MultiLineTextView: View {
    
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationStack {
//            TextEditor(text: $notes)
//                .navigationTitle("Notes")
//                .padding()
            TextField("Enter your text", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

#Preview {
    MultiLineTextView()
}
