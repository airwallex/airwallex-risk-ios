//
//  EventTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 12/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class EventTests: XCTestCase {
    func testInitFromContext() {
        let eventID = UUID()
        let context = AirwallexRiskContext(accountID: "accountID", environment: .production, tenant: .scale)
        let event = Event.mock(eventID: eventID, context: context)
        XCTAssertEqual(event.eventID, eventID)
        switch event.type {
        case .automatic(.open): break
        default: XCTFail("Should be `.automatic(.open)`")
        }
        XCTAssertEqual(event.accountID, "accountID")
        XCTAssertNil(event.userID)
        XCTAssertEqual(event.deviceID, context.deviceID)
        XCTAssertEqual(event.sessionID, context.sessionID)
        XCTAssertEqual(event.tenant, context.tenant)
        XCTAssertEqual(event.app, .init(app: context.dataCollector.app))
        XCTAssertEqual(event.device, .init(device: context.dataCollector.device))
    }

    func testUserFromContext() {
        let context = AirwallexRiskContext(accountID: "accountID", environment: .production, tenant: .scale)
        context.update(user: .init(id: "userID"))
        XCTAssertNotNil(Event.mock(context: context).accountID)
        XCTAssertNotNil(Event.mock(context: context).userID)
        context.update(user: .init(id: nil))
        XCTAssertEqual(Event.mock(context: context).accountID, "accountID")
        XCTAssertNil(Event.mock(context: context).userID)
    }
}
