//
//  AirwallexRiskClient.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

protocol ClientType {
    @discardableResult
    func log(events: [Event]) async throws -> PostEventsResponse
}

class AirwallexRiskClient: ClientType {
    private let session: URLSession
    private let context: AirwallexRiskContext

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
