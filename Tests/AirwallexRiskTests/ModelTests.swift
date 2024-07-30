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
        let encoder = JSONEncoder()
        guard let inter = try? encoder.encode(Tenant.internal),
              let pa = try? encoder.encode(Tenant.pa),
              let scale = try? encoder.encode(Tenant.scale) else {
            XCTFail("Encoding error")
            return
        }
        
        XCTAssert(String(data: inter, encoding: .utf8)?.contains("Mobile app") == true)
        XCTAssert(String(data: pa, encoding: .utf8)?.contains("PA checkout") == true)
        XCTAssert(String(data: scale, encoding: .utf8)?.contains("Scale") == true)
    }
}
