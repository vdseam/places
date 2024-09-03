//
//  Configuration.swift
//  places
//
//  Created by Vlad Deba on 03/09/2024.
//

import Foundation

class Configuration {
    static let shared = Configuration()
    
    private init() {}
    
    func getURL(for key: String) -> URL? {
        guard let path = ProcessInfo.processInfo.environment[key] else {
            print("Environment variable not found for key: \(key)")
            return nil
        }
        return URL(string: path)
    }
}
