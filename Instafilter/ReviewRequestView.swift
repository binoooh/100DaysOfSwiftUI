//
//  ReviewRequestView.swift
//  Instafilter
//
//  Created by Vinz on 6/20/25.
//

import StoreKit
import SwiftUI

struct ReviewRequestView: View {
    @Environment(\.requestReview) var requestReview
    var body: some View {
        Button("Leave Review") {
            requestReview()
        }
    }
}

#Preview {
    ReviewRequestView()
}
