//
//  AirwallexRiskContextTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class AirwallexRiskContextTests: XCTestCase {
    func testOnForegroundSessionIDDoesNotChange() {
        let context = AirwallexRiskContext(environment: .production, tenant: .scale)
        let initialSessionID = context.sessionID
        NotificationCenter.default.post(
            name: UIApplication.willEnterForegroundNotification,
            object: self,
            userInfo: nil
        )
        XCTAssertEqual(initialSessionID, context.sessionID)
    }

    func testOnBackgroundSessionIDDoesNotChange() {
        let context = AirwallexRiskContext(environment: .production, tenant: .scale)
        let initialSessionID = context.sessionID
        NotificationCenter.default.post(
            name: UIApplication.willResignActiveNotification,
            object: self,
            userInfo: nil
        )
        XCTAssertEqual(initialSessionID, context.sessionID)
    }
}
