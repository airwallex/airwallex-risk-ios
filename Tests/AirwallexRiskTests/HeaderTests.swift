//
//  HeaderTests.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class HeaderTests: XCTestCase {
    override func setUp() {
        super.setUp()
        UserDefaults.clearSDKUserDefaults()
        AirwallexRisk.start(accountID: "accountID")
    }

    func testSetAirwallexHeader() {
        var request = URLRequest(url: URL(string: "https://www.airwallex.com")!)
        XCTAssertNil(request.value(forHTTPHeaderField: AirwallexKey.header))
        request.setAirwallexHeader()
        XCTAssertNotNil(request.value(forHTTPHeaderField: AirwallexKey.header))
    }

    func testSetAirwallexHeaderNotStarted() {
        AirwallexRisk.stop()
        var request = URLRequest(url: URL(string: "https://www.airwallex.com")!)
        XCTAssertNil(request.value(forHTTPHeaderField: AirwallexKey.header))
        request.setAirwallexHeader()
        XCTAssertNil(request.value(forHTTPHeaderField: AirwallexKey.header))
    }

    func testManualHeader() throws {
        let header = try XCTUnwrap(AirwallexRisk.header)
        XCTAssertEqual(header.field, AirwallexKey.header)
        XCTAssertNotNil(header.value)
    }

    func testNoHeaderWhenStopped() {
        AirwallexRisk.stop()
        XCTAssertNil(AirwallexRisk.header)
    }
}
