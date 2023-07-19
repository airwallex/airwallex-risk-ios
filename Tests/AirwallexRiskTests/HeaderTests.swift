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
    }

    func testSharedAirwallexHeaderNotStarted() {
        XCTAssertNil(AirwallexRisk.header)
    }

    func testManualHeader() throws {
        let context = AirwallexRiskContext.test()
        let risk = AirwallexRisk(
            context: context,
            eventManager: MockEventManager()
        )
        XCTAssertEqual(risk.header.field, AirwallexKey.header)
        XCTAssertEqual(risk.header.value, context.deviceID.wrappedValue.uuidString)
    }
}
