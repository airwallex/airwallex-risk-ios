//
//  EventManagerTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class EventManagerTests: XCTestCase {
    func testQueueEvent() {
        let repository = EventRepository()
        let eventManager = EventManager.manager(
            repository: repository
        )
        XCTAssertTrue(repository.get().isEmpty)
        eventManager.queue(event: .test())
        XCTAssertEqual(repository.get().count, 1)
    }

    func testSendEventSuccess() async {
        let repository = EventRepository()
        let client = MockClient()
        client.response = .init(message: "OK")
        let eventManager = EventManager.manager(
            repository: repository,
            client: client
        )
        eventManager.queue(event: .test())
        XCTAssertEqual(repository.get().count, 1)
        await eventManager.sendEvents()
        XCTAssertTrue(repository.get().isEmpty)
    }

    func testSendEventFailure() async {
        let repository = EventRepository()
        let client = MockClient()
        let eventManager = EventManager.manager(
            repository: repository,
            client: client
        )
        eventManager.queue(event: .test())
        XCTAssertEqual(repository.get().count, 1)
        await eventManager.sendEvents()
        XCTAssertEqual(repository.get().count, 1)
    }

    func testSendNoEvent() async {
        let repository = EventRepository()
        let client = MockClient()
        let eventManager = EventManager.manager(
            repository: repository,
            client: client
        )
        XCTAssertTrue(repository.get().isEmpty)
        await eventManager.sendEvents()
        XCTAssertTrue(repository.get().isEmpty)
    }

    func testSchedule() {
        let scheduler = MockEventScheduler()
        let eventManager = EventManager.manager(
            eventScheduler: scheduler
        )
        XCTAssertFalse(scheduler.isRunning)
        eventManager.scheduleEvents()
        XCTAssertTrue(scheduler.isRunning)
    }

    func testConvenienceInit() async {
        let context = AirwallexRiskContext.test()
        let repository = EventRepository()
        let manager = EventManager.manager(
            context: context,
            repository: repository
        )
        XCTAssertEqual(repository.get().count, 1, "should start with open event")
        await manager.sendEvents()
        XCTAssertEqual(repository.get().count, .zero)
    }
}

private extension EventManager {
    static func manager(
        repository: any RepositoryType<Event> = EventRepository(),
        client: ClientType = MockClient(),
        eventScheduler: EventSchedulerType = MockEventScheduler(),
        automaticEventProvider: AutomaticEventProviderType = MockAutomaticEventProvider()
    ) -> EventManager {
        EventManager(
            repository: repository,
            client: client,
            eventScheduler: eventScheduler,
            automaticEventProvider: automaticEventProvider
        )
    }

    static func manager(
        context: AirwallexRiskContext,
        repository: any RepositoryType<Event> = EventRepository(),
        session: URLSession? = nil) -> EventManager {
            let url = URL(string: "https://staging.airwallex.com/bws/v2/m/\(context.sessionID.uuidString)")!
            let session = session ?? .successMock(url: url, encodable: PostEventsResponse(message: "Success"))
            return .init(
                context: context,
                repository: repository,
                session: session
            )
        }
}
