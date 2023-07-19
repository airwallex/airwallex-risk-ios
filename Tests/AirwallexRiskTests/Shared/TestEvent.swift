//
//  TestEvent.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 12/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
@testable import AirwallexRisk

extension Event {
    static func test(
        eventID: UUID = .init(),
        context: AirwallexRiskContext = .init(accountID: "accountID", environment: .production, tenant: .scale),
        createdAtUTC: Date = .init()
    ) -> Event {
        .init(
            eventID: eventID,
            createdAtUTC: createdAtUTC,
            type: .automatic(event: .open),
            path: "path",
            context: context
        )
    }
}
