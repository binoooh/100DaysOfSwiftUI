//
//  CodableObservableSampleView.swift
//  CupcakeCorner
//
//  Created by Vinz on 6/1/25.
//

import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name = "Vinz"
}

struct CodableObservableSampleView: View {
    var body: some View {
        Button("Encode Name", action: encodeName)
    }
    
    func encodeName() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    CodableObservableSampleView()
}
