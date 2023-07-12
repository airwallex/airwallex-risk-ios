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
        XCTAssertEqual(EventType.automatic(event: .firstLaunch), EventType(stringValue: "firstLaunch"))
        XCTAssertEqual(EventType.automatic(event: .open), EventType(stringValue: "open"))
        XCTAssertEqual(EventType.automatic(event: .background), EventType(stringValue: "background"))
        XCTAssertEqual(EventType.app(event: .login), EventType(stringValue: "login"))
        XCTAssertEqual(EventType.app(event: .logout), EventType(stringValue: "logout"))
        XCTAssertEqual(EventType.unknown, EventType(stringValue: "unknown"))
        XCTAssertEqual(EventType.unknown, EventType(stringValue: "firstLunch"))
    }

    func testCodableAutomaticEventType() throws {
        let event = MockEvent(type: .automatic(event: .open))
        let data = try JSONEncoder().encode(event)
        XCTAssertEqual(data.jsonString, "{\"type\":\"open\"}")
        let decodedEvent = try JSONDecoder().decode(MockEvent.self, from: data)
        XCTAssertEqual(event.type, decodedEvent.type)
    }

    func testCodableAppEventType() throws {
        let event = MockEvent(type: .app(event: .login))
        let data = try JSONEncoder().encode(event)
        XCTAssertEqual(data.jsonString, "{\"type\":\"login\"}")
        let decodedEvent = try JSONDecoder().decode(MockEvent.self, from: data)
        XCTAssertEqual(event.type, decodedEvent.type)
    }

    func testCodableUnknownEventType() throws {
        let event = MockEvent(type: .unknown)
        let data = try JSONEncoder().encode(event)
        XCTAssertEqual(data.jsonString, "{\"type\":\"unknown\"}")
        let decodedEvent = try JSONDecoder().decode(MockEvent.self, from: data)
        XCTAssertEqual(event.type, decodedEvent.type)
    }
}

private struct MockEvent: Codable {
    let type: EventType
}

private extension Data {
    var jsonString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.sortedKeys]),
              let jsonString = String(data: data, encoding: .utf8) else { return nil }

        return jsonString
    }
}
