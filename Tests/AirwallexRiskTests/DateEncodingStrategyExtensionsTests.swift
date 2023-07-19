//
//  DateEncodingStrategyExtensionsTests.swift
//  
//
//  Created by Richie Shilton on 13/7/2023.
//

import XCTest
@testable import AirwallexRisk

final class DateEncodingStrategyExtensionsTests: XCTestCase {
    private let container = DateContainer(
        date: .init(timeIntervalSince1970: 1689230812956.123456)
    )

    func testEncodingWithMillisecondDateStrategy() throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        let data = try encoder.encode(container)
        let jsonString = try data.jsonString
        XCTAssertEqual(jsonString, "{\"date\":1689230812956123.5}")
    }

    func testEncodingWithWholeMillisecondDateStrategy() throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .wholeMillisecondsSince1970
        let data = try encoder.encode(container)
        let jsonString = try data.jsonString
        XCTAssertEqual(jsonString, "{\"date\":1689230812956123}")
    }
}
