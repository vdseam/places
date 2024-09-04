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
            throw LocationRepositoryError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse, 
                !(200...299).contains(httpResponse.statusCode) {
                throw LocationRepositoryError.networkError(URLError(.badServerResponse))
            }
            let decodedResponse = try JSONDecoder().decode(LocationsResponse.self, from: data)
            return decodedResponse.locations
            
        } catch let error as URLError {
            throw LocationRepositoryError.networkError(error)
        } catch let error as DecodingError {
            throw LocationRepositoryError.decodingError(error)
        } catch {
            throw LocationRepositoryError.unknownError
        }
    }
}
