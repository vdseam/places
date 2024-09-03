//
//  LocationRepository.swift
//  places
//
//  Created by Vlad Deba on 03/09/2024.
//

import Foundation



protocol LocationRepositoryProtocol {
    func fetchLocations(completion: @escaping (Result<[Location], Error>) -> Void)
}

class LocationRepository: LocationRepositoryProtocol {
    func fetchLocations(completion: @escaping (Result<[Location], Error>) -> Void) {
        guard let url = Environment.shared.getURL(for: "LOCATIONS_URL") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            
            do {
                let locationsResponse = try JSONDecoder().decode(LocationsResponse.self, from: data)
                completion(.success(locationsResponse.locations))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
