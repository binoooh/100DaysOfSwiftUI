//
//  PhotosPickerView.swift
//  Instafilter
//
//  Created by Vinz on 6/19/25.
//

import PhotosUI
import SwiftUI

struct PhotosPickerView: View {
    
    @State private var pickerImages = [PhotosPickerItem]()
    @State private var selectedIamges = [Image]()
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerImages, maxSelectionCount: 3, matching: .any(of: [.images, .not(.screenshots)])) {
                Label("Select a picture", systemImage: "photo")
            }
            ScrollView {
                ForEach(0..<selectedIamges.count, id: \.self) { image in
                    selectedIamges[image]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerImages) {
            Task {
                selectedIamges.removeAll()
                for item in pickerImages {
                    if let loadImage = try await item.loadTransferable(type: Image.self) {
                        selectedIamges.append(loadImage)
                    }
                }
            }
        }
    }
}

#Preview {
    PhotosPickerView()
}
