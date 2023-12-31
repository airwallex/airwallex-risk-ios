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
        let event = Event.test(eventID: eventID, context: context)
        XCTAssertEqual(event.eventID, eventID)
        switch event.event.type {
        case .automatic(.open): break
        default: XCTFail("Should be `.automatic(.open)`")
        }
        XCTAssertEqual(event.accountID, "accountID")
        XCTAssertNil(event.userID)
        XCTAssertEqual(event.deviceID, context.deviceID.wrappedValue)
        XCTAssertEqual(event.sessionID, context.sessionID)
        XCTAssertEqual(event.tenant, context.tenant)
        XCTAssertEqual(event.app, .init(app: context.dataCollector.app))
        XCTAssertEqual(event.device, .init(device: context.dataCollector.device))
    }

    func testUserFromContext() {
        let context = AirwallexRiskContext(accountID: "accountID", environment: .production, tenant: .scale)
        context.update(userID: "userID")
        XCTAssertNotNil(Event.test(context: context).accountID)
        XCTAssertNotNil(Event.test(context: context).userID)
        context.update(userID: nil)
        XCTAssertEqual(Event.test(context: context).accountID, "accountID")
        XCTAssertNil(Event.test(context: context).userID)
        context.update(accountID: nil)
        XCTAssertNil(Event.test(context: context).accountID)
        XCTAssertNil(Event.test(context: context).userID)
    }
}
