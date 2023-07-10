//
//  EncodableExtensionsTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class EncodableExtensionsTests: XCTestCase {
    func testJdonData() throws {
        let id = "Identifier"
        let test = CodableMock(id: id)
        let data = test.jsonData
        let unwrappedData = try XCTUnwrap(data)
        let decoded = try JSONDecoder().decode(CodableMock.self, from: unwrappedData)
        XCTAssertEqual(decoded.id, id)
    }
}
