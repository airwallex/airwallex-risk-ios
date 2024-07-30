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
    func testConvenienceInit() {
        let config = AirwallexRiskConfiguration()
        XCTAssertEqual(config.environment, .production)
        XCTAssertEqual(config.tenant, .scale)
    }

    func testCustomConvenienceInit() {
        let config = AirwallexRiskConfiguration(isProduction: false, tenant: .internal)
        XCTAssertEqual(config.environment, .demo)
        XCTAssertEqual(config.tenant, .internal)
    }
    
    func testCustomInit() {
        let config = AirwallexRiskConfiguration(environment: .staging, tenant: .pa)
        XCTAssertEqual(config.environment, .staging)
        XCTAssertEqual(config.tenant, .pa)
    }
}
