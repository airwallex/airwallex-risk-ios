//
//  AirwallexRiskEnvironmentTests.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class AirwallexRiskEnvironmentTests: XCTestCase {
    func testHosts() {
        XCTAssertEqual(AirwallexRiskEnvironment.production.host, "www.airwallex.com")
        XCTAssertEqual(AirwallexRiskEnvironment.demo.host, "demo.airwallex.com")
        XCTAssertEqual(AirwallexRiskEnvironment.staging.host, "staging.airwallex.com")
    }
}
