//
//  AirwallexRiskConfigurationTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 18/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class AirwallexRiskConfigurationTests: XCTestCase {
    func testDefaultInit() {
        let config = AirwallexRiskConfiguration()
        XCTAssertEqual(config.environment, .production)
        XCTAssertEqual(config.tenant, .scale)
    }

    func testCustomInit() {
        let config = AirwallexRiskConfiguration(isProduction: false, tenant: .internal)
        XCTAssertEqual(config.environment, .demo)
        XCTAssertEqual(config.tenant, .internal)
    }
}
