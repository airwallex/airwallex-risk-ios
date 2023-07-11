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
        XCTAssertNil(request.value(forHTTPHeaderField: header.field))
        request.setAirwallexHeader()
        XCTAssertEqual(request.value(forHTTPHeaderField: header.field), AirwallexRisk.shared.context?.device.id.uuidString)
    }

    func testManualHeader() throws {
        let header = try XCTUnwrap(AirwallexRisk.header)
        XCTAssertEqual(header.field, AirwallexKey.header)
        XCTAssertEqual(header.value, AirwallexRisk.shared.context?.device.id.uuidString)
    }
}
