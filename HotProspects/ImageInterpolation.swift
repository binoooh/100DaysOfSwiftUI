//
//  ImageInterpolation.swift
//  HotProspects
//
//  Created by bino on 6/28/25.
//

import SwiftUI

struct ImageInterpolation: View {
    var body: some View {
        Image(.example)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .background(.black)
    }
}

#Preview {
    ImageInterpolation()
}
