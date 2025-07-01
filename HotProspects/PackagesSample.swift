//
//  PackagesSample.swift
//  HotProspects
//
//  Created by bino on 6/28/25.
//

import SwiftUI
import SamplePackage

struct PackagesSample: View {
    
    let possibleNumber = 1...60
    
    var results: String {
        let selected = possibleNumber.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
    var body: some View {
        Text(results)
    }
}

#Preview {
    PackagesSample()
}
