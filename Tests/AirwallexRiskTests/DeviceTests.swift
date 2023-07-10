//
//  DeviceTests.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class DeviceTests: XCTestCase {
    private let device = Device()

    func testValues() {
        XCTAssertNotNil(device.timezone)
        XCTAssertNotNil(device.language)
        XCTAssertNotNil(device.countryISO)
        XCTAssertEqual(device.osName, UIDevice.current.systemName)
        XCTAssertEqual(device.osVersion, UIDevice.current.systemVersion)
        XCTAssertEqual(device.model.prefix(6), "iPhone")
        XCTAssertEqual(device.modelBrand, "Apple")
    }
}
