//
//  MockEventManager.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
@testable import AirwallexRisk

extension EventManager {
    static func mock(
        context: AirwallexRiskContext = .mock(),
        repository: EventRepository = .init()
    ) -> EventManager {
        .init(context: context, repository: repository)
    }
}
