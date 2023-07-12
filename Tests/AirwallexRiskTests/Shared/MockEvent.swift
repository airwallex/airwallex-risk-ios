//
//  MockEvent.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 12/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
@testable import AirwallexRisk

extension Event {
    static func mock(
        eventID: UUID = .init(),
        context: AirwallexRiskContext = .init(environment: .production, tenant: .scale),
        createdAtUTC: Date = .init()
    ) -> Event {
        .init(
            eventID: eventID,
            type: .automatic(event: .open),
            context: context,
            createdAtUTC: createdAtUTC
        )
    }
}
