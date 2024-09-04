//
//  DeepLink.swift
//  places
//
//  Created by Vlad Deba on 04/09/2024.
//

import Foundation

class DeepLink {
    private let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func generate(for location: Location) -> URL? {
        let queryItems = [
            URLQueryItem(name: "lat", value: String(location.lat)),
            URLQueryItem(name: "long", value: String(location.long))
        ]
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
}
