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
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var showingFilters = false
    @State private var pickedItem = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
//    let filters = ["Crystallize", "Sepia Tone", "Gaussian Blur", "Pixellate", "Unsharp Mask", "Vignette"]
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
                
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 8) {
//                        ForEach(0..<filters.count, id: \.self) { i in
//                            VStack {
//                                if let processedImage {
//                                    processedImage
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 60, height: 60)
//                                    Text(filters[i])
//                                        .font(.caption2)
//                                }
//                            }
//                        }
//                    }
//                }
                
                HStack {
                    VStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyIntensity)
                            .disabled(!pickedItem)
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius, applyRadius)
                            .disabled(!pickedItem)
                        Text("Scale")
                        Slider(value: $filterScale)
                            .onChange(of: filterScale, applyScale)
                            .disabled(!pickedItem)
                    }
                }
                .padding(.vertical)
                
                HStack {
                    
                    Button("Change Filter") {
                        changeFilter()
                    }
                    .disabled(!pickedItem)
                    
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
            pickedItem = true
            applyProcessing()
        }
    }
    
    func applyIntensity() {
        //currentFilter = filter
        if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
            print("Intensity: \(filterIntensity)")
        }
        applyProcessing()
    }
    
    func applyRadius() {
        //currentFilter = filter
        if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
            print("Radius: \(filterRadius)")
        }
        applyProcessing()
    }
    
    func applyScale() {
        //currentFilter = filter
        if currentFilter.inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
            print("Scale: \(filterScale)")
        }
        applyProcessing()
    }
    
    func applyProcessing() {
        // Set the currentFilter's intensity
//        let inputKeys = currentFilter.inputKeys
//
//        if inputKeys.contains(kCIInputIntensityKey) {
//            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
//            print("Intensity: \(filterIntensity)")
//        }
//        if inputKeys.contains(kCIInputRadiusKey) {
//            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
//            print("Radius: \(filterRadius)")
//        }
//        if inputKeys.contains(kCIInputScaleKey) {
//            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
//            print("Scale: \(filterScale)")
//        }
        
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
        pickedItem = true

        if filterCount >= 2 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
