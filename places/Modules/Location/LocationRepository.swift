//
//  LocationRepository.swift
//  places
//
//  Created by Vlad Deba on 03/09/2024.
//

import Foundation

protocol LocationRepositoryProtocol {
    func fetchLocations() async throws -> [Location]
}

class LocationRepository: LocationRepositoryProtocol {
    func fetchLocations() async throws -> [Location] {
        guard let url = Configuration.shared.getURL(for: "LOCATIONS_URL") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(LocationsResponse.self, from: data)
        return response.locations
    }
}
