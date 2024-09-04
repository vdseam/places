//
//  DeepLinkTests.swift
//  DeepLinkTests
//
//  Created by Vlad Deba on 04/09/2024.
//

import XCTest

@testable import places

final class DeepLinkTests: XCTestCase {
    var deepLink: DeepLink!
    
    override func setUp() {
        super.setUp()
        deepLink = DeepLink(baseURL: "wikipedia://places")
    }
    
    override func tearDown() {
        deepLink = nil
        super.tearDown()
    }
    
    func testGenerateValidURL() {
        // Given
        let location = Location(lat: 37.7749, long: -122.4194)
        
        // When
        let url = deepLink.generate(for: location)
        
        // Then
        XCTAssertNotNil(url, "The generated URL should not be nil")
        XCTAssertEqual(url?.absoluteString, "wikipedia://places?lat=37.7749&long=-122.4194")
    }
    
    func testGenerateURLWithNegativeCoordinates() {
        // Given
        let location = Location(lat: -37.7749, long: -122.4194)
        
        // When
        let url = deepLink.generate(for: location)
        
        // Then
        XCTAssertNotNil(url, "The generated URL should not be nil for negative coordinates")
        XCTAssertEqual(url?.absoluteString, "wikipedia://places?lat=-37.7749&long=-122.4194")
    }
    
    func testGenerateURLWithZeroCoordinates() {
        // Given
        let location = Location(lat: 0.0, long: 0.0)
        
        // When
        let url = deepLink.generate(for: location)
        
        // Then
        XCTAssertNotNil(url, "The generated URL should not be nil for zero coordinates")
        XCTAssertEqual(url?.absoluteString, "wikipedia://places?lat=0.0&long=0.0")
    }
}
