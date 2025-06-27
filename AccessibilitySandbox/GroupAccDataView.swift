//
//  GroupAccDataView.swift
//  AccessibilitySandbox
//
//  Created by Vinz on 6/26/25.
//

import SwiftUI

struct GroupAccDataView: View {
    var body: some View {
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        //.accessibilityElement(children: .children)    // This reads the text on VStack with pause
        .accessibilityElement(children: .ignore)        // This will ignore the text on VStack
        .accessibilityLabel("Your score is 1000")       // This will be voice overed more naturally
    }
}

#Preview {
    GroupAccDataView()
}
