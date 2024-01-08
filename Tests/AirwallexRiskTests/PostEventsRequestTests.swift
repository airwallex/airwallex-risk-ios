//
//  PostEventsRequestTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class PostEventsRequestTests: XCTestCase {
    private var testContext: AirwallexRiskContext!

    override func setUp() {
        testContext = .test()
    }

    func testInit() throws {
        let request = PostEventsRequest(events: [.init(type: .custom(event: "login"), context: testContext)], context: testContext)
        let urlRequest: URLRequest = try .init(request: request)
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://bws-staging.airwallex.com/bws/v2/m/\(testContext.sessionID)")
    }
}
