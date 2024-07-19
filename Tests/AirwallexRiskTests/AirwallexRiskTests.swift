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
    private var repository: EventRepository!
    private var testContext: AirwallexRiskContext!
    private var testEventManager: MockEventManager!
    private var airwallexRisk: Risk!

    override func setUp() {
        repository = .init()
        testContext = .test()
        testEventManager = .init()
        airwallexRisk = Risk(
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
        XCTAssertEqual(testEventManager.events.count, .zero)
        airwallexRisk.log(event: "login")
        XCTAssertEqual(testEventManager.events.count, 1)
    }
}
