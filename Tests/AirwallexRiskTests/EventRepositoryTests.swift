//
//  EventRepositoryTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 12/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class EventRepositoryTests: XCTestCase {
    func testAdd() {
        let repo = EventRepository()
        XCTAssertTrue(repo.events.isEmpty)
        repo.add(event: .mock())
        XCTAssertEqual(repo.events.count, 1)
        repo.add(event: .mock())
        XCTAssertEqual(repo.events.count, 2)
    }

    func testRemove() {
        let repo = EventRepository()
        XCTAssertTrue(repo.events.isEmpty)
        let mock = Event.mock()
        repo.add(event: mock)
        repo.add(event: .mock())
        repo.add(event: .mock())
        XCTAssertEqual(repo.events.count, 3)
        repo.remove(event: mock)
        XCTAssertEqual(repo.events.count, 2)
        repo.removeAll()
        XCTAssertTrue(repo.events.isEmpty)
    }
}
