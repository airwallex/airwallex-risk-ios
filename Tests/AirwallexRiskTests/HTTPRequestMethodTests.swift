//
//  HTTPRequestMethodTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class HTTPRequestMethodTests: XCTestCase {
    func testCustomStringConvertible() {
        XCTAssertEqual(String(describing: HTTPRequestMethod.get), "GET")
        XCTAssertEqual(String(describing: HTTPRequestMethod.post(body: CodableMock(id: "id"))), "POST")
    }
}
