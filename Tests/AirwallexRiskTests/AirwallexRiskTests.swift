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
        AirwallexRisk.start()
    }

    func testStart() {
        // TODO: -
    }

    func testUserStorage() throws {
        let accountID = UUID()
        let userID = UUID()
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
}
