//
//  MockContext.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
@testable import AirwallexRisk

extension AirwallexRiskContext {
    static func test(
        accountID: String = "accountID"
    ) -> AirwallexRiskContext {
        .init(
            accountID: accountID,
            environment: .staging,
            tenant: .internal
        )
    }
}
