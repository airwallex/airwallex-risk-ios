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
        AirwallexRisk.start()
        UserDefaults.sdk?.removeObject(forKey: AirwallexUserDefaultKey.deviceID)
    }

    func testSetAirwallexHeader() throws {
        var request = URLRequest(url: URL(string: "https://www.airwallex.com")!)
        let header = try XCTUnwrap(AirwallexRisk.header)
        XCTAssertNil(request.value(forHTTPHeaderField: header.key))
        request.setAirwallexHeader()
        XCTAssertEqual(request.value(forHTTPHeaderField: header.key), AirwallexRisk.shared.context?.device.id.uuidString)
    }

    func testManualHeader() throws {
        let header = try XCTUnwrap(AirwallexRisk.header)
        XCTAssertEqual(header.key, AirwallexKey.header)
        XCTAssertEqual(header.value, AirwallexRisk.shared.context?.device.id.uuidString)
    }
}
