//
//  EditView.swift
//  BucketList
//
//  Created by Vinz on 6/22/25.
//

// Day 73 Coding Challenge: Created editViewModel

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    // Day 73 Coding Challenge
    @State private var editViewModel = EditViewModel(name: "Example", description: "Example", location: .example)
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // Day 73 Coding Challenge
                    TextField("Place name", text: $editViewModel.name)
                    TextField("Description", text: $editViewModel.description)
                }
                Section("Nearby...") {
                    // Day 73 Coding Challenge
                    switch editViewModel.loadingState {
                    case .loaded:
                        // Day 73 Coding Challenge
                        ForEach(editViewModel.pages, id:\.pageid) { page in
                            /*@START_MENU_TOKEN@*/Text(page.title)/*@END_MENU_TOKEN@*/
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                        
                    case .loading:
                        Text("Loading...")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    var newLocation = editViewModel.location            // Day 73 Coding Challenge
                    newLocation.id = UUID()
                    newLocation.name = editViewModel.name               // Day 73 Coding Challenge
                    newLocation.description = editViewModel.description // Day 73 Coding Challenge
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                // Day 73 Coding Challenge
                await editViewModel.fetchNearbyPlaces()
            }
        }
        
    }
    init(location: Location, onSave: @escaping (Location) -> Void) {
        // Day 73 Coding Challenge
        self.onSave = onSave
        _editViewModel = State(initialValue: EditViewModel(name: location.name, description: location.description, location: location))
    }
}

#Preview {
    EditView(location: .example) { _ in }
}
