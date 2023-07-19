//
//  EventTypeTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 12/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class EventTypeTests: XCTestCase {
    func testInitFromStringValue() {
        XCTAssertEqual(EventType.automatic(event: .installation), EventType(stringValue: "installation"))
        XCTAssertEqual(EventType.automatic(event: .open), EventType(stringValue: "open"))
        XCTAssertEqual(EventType.custom(event: "login"), EventType(stringValue: "login"))
    }

    func testCodableAutomaticEventType() throws {
        let event = MockEvent(type: .automatic(event: .open))
        let data = try JSONEncoder().encode(event)
        XCTAssertEqual(try data.jsonString, "{\"type\":\"open\"}")
        let decodedEvent = try JSONDecoder().decode(MockEvent.self, from: data)
        XCTAssertEqual(event.type, decodedEvent.type)
    }

    func testCodableAppEventType() throws {
        let event = MockEvent(type: .custom(event: "login"))
        let data = try JSONEncoder().encode(event)
        XCTAssertEqual(try data.jsonString, "{\"type\":\"login\"}")
        let decodedEvent = try JSONDecoder().decode(MockEvent.self, from: data)
        XCTAssertEqual(event.type, decodedEvent.type)
    }
}

private struct MockEvent: Codable {
    let type: EventType
}
