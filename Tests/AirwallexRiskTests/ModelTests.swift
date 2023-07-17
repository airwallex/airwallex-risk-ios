//
//  ModelTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class ModelTests: XCTestCase {
    func testAirwallexID() {
        let defaultAirwallexID = AirwallexID.defaultValue()
        XCTAssertNil(defaultAirwallexID.id)
    }

    func testTenant() {
        XCTAssertEqual(Tenant.internal.rawValue, "mobile-app")
        XCTAssertEqual(Tenant.pa.rawValue, "pa-checkout")
        XCTAssertEqual(Tenant.scale.rawValue, "scale")
    }
}
