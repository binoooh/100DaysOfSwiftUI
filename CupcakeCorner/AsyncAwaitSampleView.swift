//
//  AsyncAwaitSampleView.swift
//  CupcakeCorner
//
//  Created by Vinz on 5/31/25.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct AsyncAwaitSampleView: View {
    
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            Text(item.trackName)
                .font(.headline)
            Text(item.collectionName)
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResonse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResonse.results
            }
        } catch {
            print("Invalid Data")
        }
    }
}

#Preview {
    AsyncAwaitSampleView()
}
