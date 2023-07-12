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
    override func setUp() {
        AirwallexRisk.stop()
    }

    func testStart() {
        XCTAssertNil(AirwallexRisk.shared.context)
        XCTAssertNil(AirwallexRisk.shared.eventManager)
        AirwallexRisk.start()
        XCTAssertNotNil(AirwallexRisk.shared.context)
        XCTAssertNotNil(AirwallexRisk.shared.eventManager)
    }

    func testUserStorage() throws {
        let accountID = UUID()
        let userID = UUID()
        AirwallexRisk.set(accountID: accountID, userID: userID)
        XCTAssertNil(AirwallexRisk.shared.context)
        AirwallexRisk.start()
        let context = try XCTUnwrap(AirwallexRisk.shared.context)
        XCTAssertNil(context.user.accountID)
        XCTAssertNil(context.user.userID)
        AirwallexRisk.set(accountID: accountID, userID: userID)
        XCTAssertEqual(context.user.accountID, accountID)
        XCTAssertEqual(context.user.userID, userID)
        AirwallexRisk.set(accountID: accountID, userID: nil)
        XCTAssertEqual(context.user.accountID, accountID)
        XCTAssertNil(context.user.userID)

        UserDefaults.sdk?.removeObject(forKey: AirwallexUserDefaultKey.user)
        XCTAssertNil(context.user.accountID)
        XCTAssertNil(context.user.userID)
    }

    func testLogEvent() throws {
        AirwallexRisk.start()
        let eventManager = try XCTUnwrap(AirwallexRisk.shared.eventManager)
        XCTAssertTrue(eventManager.repository.events.isEmpty)
        AirwallexRisk.log(event: .login)
        XCTAssertEqual(eventManager.repository.events.count, 1)
        XCTAssertEqual(eventManager.repository.events.first?.type, .app(event: .login))
    }

    func testLogEventNotStarted() {
        XCTAssertNil(AirwallexRisk.shared.eventManager)
        AirwallexRisk.log(event: .login)
        XCTAssertNil(AirwallexRisk.shared.eventManager)
    }
}
