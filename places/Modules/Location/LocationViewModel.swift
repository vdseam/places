//
//  LocationViewModel.swift
//  places
//
//  Created by Vlad Deba on 03/09/2024.
//

import SwiftUI

class LocationViewModel: ObservableObject {
    @Published var locations: [Location] = []
    private let repository: LocationRepositoryProtocol
    
    init(repository: LocationRepositoryProtocol = LocationRepository()) {
        self.repository = repository
    }
    
    func fetchLocations() {
        Task {
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
}
