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
        XCTAssertTrue(repo.get().isEmpty)
        repo.add(.mock())
        XCTAssertEqual(repo.get().count, 1)
        repo.add(.mock())
        XCTAssertEqual(repo.get().count, 2)
    }

    func testPopAll() {
        let repo = EventRepository()
        XCTAssertTrue(repo.get().isEmpty)
        let mock = Event.mock()
        repo.add(mock)
        repo.add([.mock(), .mock()])
        XCTAssertEqual(repo.get().count, 3)
        let events = repo.popAll()
        XCTAssertEqual(events?.count, 3)
        XCTAssertTrue(repo.get().isEmpty)
        XCTAssertNil(repo.popAll())
    }
}
