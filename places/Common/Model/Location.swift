//
//  Location.swift
//  places
//
//  Created by Vlad Deba on 03/09/2024.
//

import Foundation

struct Location: Codable, Identifiable {
    let id = UUID()
    var name: String?
    let lat: Double
    let long: Double
    
    enum CodingKeys: String, CodingKey {
        case name, lat, long
    }
}
