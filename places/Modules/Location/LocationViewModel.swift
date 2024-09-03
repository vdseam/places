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
        repository.fetchLocations { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    self?.locations = locations
                case .failure(let error):
                    print("Failed to fetch locations: \(error.localizedDescription)")
                }
            }
        }
    }
}
