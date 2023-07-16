//
//  File.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

struct EventRequest: HTTPRequestType {
    var host: String
    var path: String
    var method: HTTPRequestMethod

    init(
        events: [Event],
        context: AirwallexRiskContext
    ) {
        self.host = context.environment.host
        self.path = "/bws/v2/m/\(context.sessionID.uuidString)"
        self.method = .post(body: events)
    }
}
