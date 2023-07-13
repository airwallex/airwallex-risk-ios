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
        let context = AirwallexRiskContext(environment: .production, tenant: .scale)
        let event = Event.mock(eventID: eventID, context: context)
        XCTAssertEqual(event.eventID, eventID)
        switch event.type {
        case .automatic(.open): break
        default: XCTFail("Should be `.automatic(.open)`")
        }
        XCTAssertNil(event.accountID)
        XCTAssertNil(event.userID)
        XCTAssertEqual(event.deviceID, context.deviceID)
        XCTAssertEqual(event.sessionID, context.sessionID)
        XCTAssertEqual(event.tenant, context.tenant)
        XCTAssertTrue(event.isApp)
        XCTAssertEqual(event.app, .init(app: context.app))
        XCTAssertEqual(event.device, .init(device: context.device))
    }

    func testUserFromContext() {
        let context = AirwallexRiskContext(environment: .production, tenant: .scale)
        context.update(user: .init(accountID: UUID(), userID: UUID()))
        XCTAssertNotNil(Event.mock(context: context).accountID)
        XCTAssertNotNil(Event.mock(context: context).userID)
        context.update(user: .init(accountID: nil, userID: nil))
        XCTAssertNil(Event.mock(context: context).accountID)
        XCTAssertNil(Event.mock(context: context).userID)
    }
}
