//
//  LocationRepositoryError.swift
//  places
//
//  Created by Vlad Deba on 04/09/2024.
//

import Foundation

enum LocationRepositoryError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case unknownError
}
