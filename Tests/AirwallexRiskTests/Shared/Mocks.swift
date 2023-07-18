//
//  Mocks.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
@testable import AirwallexRisk

class MockEventManager: EventManagerType {
    var events: [Event] = []
    var didScheduleEvents = false

    func queue(event: Event) {
        events.append(event)
    }

    func sendEvents() async {
        events = []
    }

    func scheduleEvents() {
        didScheduleEvents = true
    }
}

class MockClient: ClientType {
    var response: PostEventsResponse?

    func log(events: [Event]) async throws -> PostEventsResponse {
        guard let response else {
            throw HTTPResponseError.invalid(statusCode: 500)
        }
        return response
    }
}

class MockEventScheduler: EventSchedulerType {
    var isRunning = false
    var didFire = false

    func scheduleRepeating(block: @escaping () async -> Void) {
        isRunning = true
    }

    func fire() {
        didFire = true
    }

    func stop() {
        isRunning = false
    }


}

class MockAutomaticEventProvider: AutomaticEventProviderType {
    var didCallOpenEvent = false
    func openEvent() {
        didCallOpenEvent = true
    }
}
