//
//  AirwallexRiskTests.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class AirwallexRiskTests: XCTestCase {
    private var testContext: AirwallexRiskContext!
    private var testEventManager: EventManager!
    private var airwallexRisk: AirwallexRisk!

    override func setUp() {
        testContext = .mock()
        testEventManager = .mock()
        airwallexRisk = AirwallexRisk(
            context: testContext,
            eventManager: testEventManager
        )
    }

    func testHeader() {
        XCTAssertEqual(airwallexRisk.header.field, AirwallexKey.header)
        XCTAssertEqual(airwallexRisk.header.value, testContext.deviceID.wrappedValue.uuidString)
    }

    func testSetAccountID() {
        let id = "accountID2"
        XCTAssertEqual(testContext.account.wrappedValue.id, "accountID")
        airwallexRisk.set(accountID: id)
        XCTAssertEqual(testContext.account.wrappedValue.id, "accountID2")
        XCTAssertEqual(testContext.account.wrappedValue.id, id)
        airwallexRisk.set(accountID: nil)
        XCTAssertNil(testContext.account.wrappedValue.id)
    }

    func testSetUserID() {
        let id = "userID"
        XCTAssertNil(testContext.user.wrappedValue.id)
        airwallexRisk.set(userID: id)
        XCTAssertEqual(testContext.user.wrappedValue.id, id)
        airwallexRisk.set(userID: nil)
        XCTAssertNil(testContext.user.wrappedValue.id)
    }

    func testLogEvent() {
        XCTAssertTrue(testEventManager.repository.events.isEmpty)
        airwallexRisk.log(event: "login")
        XCTAssertEqual(testEventManager.repository.events.count, 1)
        XCTAssertEqual(testEventManager.repository.events.first?.type, .custom(event: "login"))
    }
}
