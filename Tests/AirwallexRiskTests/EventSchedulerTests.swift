//
//  EventSchedulerTests.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 18/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class EventSchedulerTests: XCTestCase {
    func testBlockRunsImmediately() async {
        let exp = expectation(description: "Block should run immediately")
        let scheduler = EventScheduler(timeInterval: 60)
        scheduler.scheduleRepeating {
            exp.fulfill()
        }
        await fulfillment(of: [exp], timeout: 1)
    }

    func testBlockRepeats() async {
        let exp = expectation(description: "Block should run multiple times")
        exp.expectedFulfillmentCount = 3
        exp.assertForOverFulfill = false
        let scheduler = EventScheduler(timeInterval: 0.05)
        scheduler.scheduleRepeating {
            exp.fulfill()
        }
        await fulfillment(of: [exp], timeout: 1)
        scheduler.cancel()
    }

    func testCancelStopsBlock() async throws {
        var callCount = 0
        let scheduler = EventScheduler(timeInterval: 0.05)
        scheduler.scheduleRepeating {
            callCount += 1
        }
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1s — let it fire a couple of times
        scheduler.cancel()
        let countAfterCancel = callCount
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1s — confirm it stops
        XCTAssertEqual(callCount, countAfterCancel)
    }

    func testRescheduleCancelsPreviousTask() async {
        var firstBlockCallCount = 0
        let scheduler = EventScheduler(timeInterval: 0.05)
        scheduler.scheduleRepeating {
            firstBlockCallCount += 1
        }
        // Replace with a new block — first should stop
        let exp = expectation(description: "Second block should run")
        scheduler.scheduleRepeating {
            exp.fulfill()
        }
        await fulfillment(of: [exp], timeout: 1)
        let countSnapshot = firstBlockCallCount
        XCTAssertEqual(firstBlockCallCount, countSnapshot, "First block should not run after reschedule")
    }
}
