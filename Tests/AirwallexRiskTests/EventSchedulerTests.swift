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
    func testSchedule() {
        let exp = expectation(description: "Should run the block on timer")
        var hasRun = false
        let block = { hasRun = true }
        let scheduler = EventScheduler(timeInterval: 0.05)
        XCTAssertFalse(hasRun)
        scheduler.scheduleRepeating(block: block)
        XCTAssertFalse(hasRun)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(hasRun)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.2)
    }
}
