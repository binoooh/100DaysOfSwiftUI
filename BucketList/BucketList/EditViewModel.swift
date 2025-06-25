//
//  EditViewModel.swift
//  BucketList
//
//  Created by Vinz on 6/24/25.
//

// Day 73 Coding Challenge

import Foundation
import CoreLocation

//extension EditView {
@Observable
class EditViewModel {
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    var name: String
    var description: String
    var loadingState = LoadingState.loading
    var pages = [Page]()
    var location: Location
    
    init(name: String, description: String, loadingState: LoadingState = LoadingState.loading, pages: [Page] = [Page](), location: Location) {
        self.name = name
        self.description = description
        self.loadingState = loadingState
        self.pages = pages
        self.location = location
    }
    
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }
}
//}
