//
//  ContentView.swift
//  Instafilter
//
//  Created by Vinz on 6/18/25.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    @AppStorage("filterCount") var filterCount = 0
    @State private var processedImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    @State private var filterIntensity = 0.5
    @State private var showingFilters = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                
                Spacer()
                
                HStack {
                    Text("Intensity")
                        Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        changeFilter()
                    }
                    
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Kaleidoscope") { setFilter(CIFilter.kaleidoscope()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {
                return
            }
            guard let inputImage = UIImage(data: imageData) else {
                return
            }
            // Set beingImage with created CIImage
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        // Set the currentFilter's intensity
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputColorKey) { currentFilter.setValue(filterIntensity * 100, forKey: kCIInputColorKey)  }
        
        // Get the currentFilter's image
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        // Create a CGImage
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return
        }
        // Create a UIIMage
        let uiImage = UIImage(cgImage: cgImage)
        // Set proceesedImage to the created UIImage
        processedImage = Image(uiImage: uiImage)
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        filterCount += 1

        if filterCount >= 2 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
