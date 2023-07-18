//
//  AirwallexRiskClient.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

class AirwallexRiskClient {
    let session: URLSession
    let context: AirwallexRiskContext

    init(
        session: URLSession,
        context: AirwallexRiskContext
    ) {
        self.session = session
        self.context = context
    }

    @discardableResult
    func log(events: [Event]) async throws -> PostEventsResponse {
        let request = PostEventsRequest(events: events, context: context)
        return try await session.execute(request: request)
    }
}
