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
    func testAccount() {
        let defaultAccount = Account.defaultValue()
        XCTAssertNil(defaultAccount.id)
    }

    func testUser() {
        let defaultUser = User.defaultValue()
        XCTAssertNil(defaultUser.id)
    }

    func testTenant() {
        XCTAssertEqual(Tenant.internal.rawValue, "mobile-app")
        XCTAssertEqual(Tenant.pa.rawValue, "pa-checkout")
        XCTAssertEqual(Tenant.scale.rawValue, "scale")
    }
}
