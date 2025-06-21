//
//  UIKitSampleFilter.swift
//  Instafilter
//
//  Created by Vinz on 6/19/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct CoreImageSampleView: View {
    
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        //currentFilter.intensity = 0.5
        
        let amount = 5
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
        // attempt to get a CGImage from our CIImage
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        // convert that to a UIImage
        let uiImage = UIImage(cgImage: cgImage)
        
        // convert that to SwiftUI image
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    CoreImageSampleView()
}
