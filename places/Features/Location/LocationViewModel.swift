//
//  LocationViewModel.swift
//  places
//
//  Created by Vlad Deba on 03/09/2024.
//

import SwiftUI

class LocationViewModel: ObservableObject {
    @Published var locations: [Location] = []
    @Published var isLoading = false
    
    private let repository: LocationRepositoryProtocol
    private let deepLink = DeepLink(baseURL: "wikipedia://places")
    
    init(repository: LocationRepositoryProtocol = LocationRepository()) {
        self.repository = repository
    }
    
    func fetchLocations() {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                self.locations = try await repository.fetchLocations()
            } catch {
                print("Failed to fetch locations: \(error.localizedDescription)")
            }
        }
    }
    
    func addLocation(name: String?, lat: Double, long: Double) {
        let newLocation = Location(name: name, lat: lat, long: long)
        locations.append(newLocation)
    }
    
    func url(for location: Location) -> URL? {
        deepLink.generate(for: location)
    }
}
