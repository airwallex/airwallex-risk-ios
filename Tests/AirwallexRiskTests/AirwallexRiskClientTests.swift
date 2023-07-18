//
//  AirwallexRiskClientTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 18/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class AirwallexRiskClientTests: XCTestCase {
    let context: AirwallexRiskContext = .test()

    func testLogEventSuccess() async throws {
        let url = URL(string: "https://staging.airwallex.com/bws/v2/m/\(context.sessionID.uuidString)")!
        let session = URLSession.successMock(url: url, encodable: PostEventsResponse(message: "Success"))
        let client = AirwallexRiskClient(session: session, context: context)
        let response = try await client.log(events: [.test()])
        XCTAssertEqual(response.message, "Success")
    }

    func testLogEventError() async {
        let url = URL(string: "https://staging.airwallex.com/bws/v2/m/\(context.sessionID.uuidString)")!
        let session = URLSession.errorMock(url: url, errorCode: 400)
        let client = AirwallexRiskClient(session: session, context: context)
        let response = try? await client.log(events: [.test()])
        XCTAssertNil(response)
    }
}
