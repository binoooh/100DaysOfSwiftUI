//
//  ContentView.swift
//  NameFace
//
//  Created by bino on 6/27/25.
//

import PhotosUI
import SwiftUI
import CoreLocation

struct ContentView: View {

    @State private var selectedItem: PhotosPickerItem?
    @State private var namedPhotos: [NamedPhoto] = []
    @State private var showingNameAlert = false
    @State private var newPhotoName: String = ""
//    @State private var photoIDToName: NamedPhoto?
    @State private var photoIDToName: UUID?
    
    // Location Manager to get current location
    @StateObject private var locationManager = LocationManager()
    
    // File storage paths
    private var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var photosArchiveURL: URL {
        documentsDirectory.appendingPathComponent("namedPhotos.plist")
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(namedPhotos.sorted(by: { $0.name < $1.name})) { namedPhoto in
                    NavigationLink(destination: DetailView(namedPhoto: namedPhoto)) {
                        HStack {
                            if let uiImage = loadImage(from: namedPhoto.photoPath) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                            }
                            Text(namedPhoto.name)
                        }
                    }
                }
                .onDelete(perform: deletePhoto)
            }
            .navigationTitle("NameFace")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let newItem = newItem,
                       let data = try? await newItem.loadTransferable(type: Data.self) {
                        // Get current location
                        guard let location = locationManager.lastKnownLocation else {
                            print("Location not available.")
                            return
                        }
                        
                        // Save photo data to a file
                        let fileName = UUID().uuidString + ".jpg"
                        let filePath = documentsDirectory.appendingPathComponent(fileName)
                        
                        do {
                            try data.write(to: filePath)
                            let newPhoto = NamedPhoto(photoPath: filePath, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                            namedPhotos.append(newPhoto)
                            // Store the ID of the photo
                            photoIDToName = newPhoto.id
                            showingNameAlert = true // Trigger the alert
                            savePhotos()
                        } catch {
                            print("Error saving photo: \(error.localizedDescription)")
                        }
                    }
                }
            }
            .alert("Name Your Photo", isPresented: $showingNameAlert, actions: {
                TextField("Photo Name", text: $newPhotoName)
                Button("Save") {
                    if let id = photoIDToName, // Get the ID of the photo to name
                       let index = namedPhotos.firstIndex(where: { $0.id == id }) {
                        namedPhotos[index].name = newPhotoName.isEmpty ? "Untitled Photo" : newPhotoName
                        savePhotos()
                        newPhotoName = ""
                        photoIDToName = nil
                    }
                }
                Button("Cancel", role: .cancel) {
                    // If the user cancels, you might want to remove the photo that was just added
                    // This is a design choice. For now, let's just clear the state.
                    if let id = photoIDToName,
                       let index = namedPhotos.firstIndex(where: { $0.id == id }) {
                        // Optionally, if you want to remove the photo if the user cancels naming:
                        // deletePhoto(at: IndexSet(integer: index))
                        namedPhotos[index].name = "Untitled Photo"
                        savePhotos()
                    }
                    newPhotoName = ""
                    photoIDToName = nil
                }
            }, message: {
                Text("Please enter a name for your new photo.")
            })
            .onAppear(perform: loadPhotos)
        }
    }
    
    private func loadImage(from url: URL) -> UIImage? {
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print("Error loading image from \(url.lastPathComponent): \(error.localizedDescription)")
            return nil
        }
    }
    
    private func savePhotos() {
        do {
            let data = try PropertyListEncoder().encode(namedPhotos)
            try data.write(to: photosArchiveURL)
        } catch {
            print("Error saving photos: \(error.localizedDescription)")
        }
    }
    
    private func loadPhotos() {
        guard FileManager.default.fileExists(atPath: photosArchiveURL.path) else { return }
        do {
            let data = try Data(contentsOf: photosArchiveURL)
            namedPhotos = try PropertyListDecoder().decode([NamedPhoto].self, from: data)
        } catch {
            print("Error loading photos: \(error.localizedDescription)")
        }
    }
    
    private func deletePhoto(at offsets: IndexSet) {
        
        // Create a temporary array of photos to delete
        let photosToRemove = offsets.map{ namedPhotos[$0] }
        
        // Remove from the namedPhotos array first
        namedPhotos.remove(atOffsets: offsets)
        savePhotos()
        
        for photo in photosToRemove {
            do {
                try FileManager.default.removeItem(at: photo.photoPath)
                print("Deleted file: \(photo.photoPath.lastPathComponent)")
            } catch {
                print("Error deleting file: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
