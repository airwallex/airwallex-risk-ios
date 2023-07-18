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
    var manager: EventManager!
    var isSuccess = false

    func testSendEventsSuccess() async {
        let context = AirwallexRiskContext.mock()
        let url = URL(string: "https://staging.airwallex.com/bws/v2/m/\(context.sessionID.uuidString)")!
        let session = URLSession.successMock(url: url, encodable: PostEventsResponse(message: "Success"))
        let repository = EventRepository()
        manager = EventManager(context: context, repository: repository, session: session)
        XCTAssertEqual(repository.get().count, 1)
        manager.queue(event: .init(type: .custom(event: "login"), context: context))
        XCTAssertEqual(repository.get().count, 2)
        await manager.sendEvents()
        XCTAssertEqual(repository.get().count, 0)
    }

    func testSendEventsError() async {
        let context = AirwallexRiskContext.mock()
        let url = URL(string: "https://staging.airwallex.com/bws/v2/m/\(context.sessionID.uuidString)")!
        let session = URLSession.errorMock(url: url, errorCode: 400)
        let repository = EventRepository()
        manager = EventManager(context: context, repository: repository, session: session)
        XCTAssertEqual(repository.get().count, 1)
        manager.queue(event: .init(type: .custom(event: "login"), context: context))
        XCTAssertEqual(repository.get().count, 2)
        await manager.sendEvents()
        XCTAssertEqual(repository.get().count, 2)
    }

    func testNoEvents() async {
        let context = AirwallexRiskContext.mock()
        let url = URL(string: "https://staging.airwallex.com/bws/v2/m/\(context.sessionID.uuidString)")!
        let session = URLSession.successMock(url: url, encodable: PostEventsResponse(message: "Success"))
        let repository = EventRepository()
        manager = EventManager(context: context, repository: repository, session: session)
        XCTAssertEqual(repository.get().count, 1)
        await manager.sendEvents()
        XCTAssertEqual(repository.get().count, .zero)
    }
}
