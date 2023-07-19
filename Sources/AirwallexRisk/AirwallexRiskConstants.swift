//
//  AirwallexRiskConstants.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

enum AirwallexValue {
    static let apple = "Apple"
    static let simulator = "(simulator)"
    static let unknown = "unknown"
    static let contentJSON = "application/json"
    static let scheme = "https"
    static let notStartedWarning = "Please call `AirwallexRisk.start()` on app launch."

    static func timeInterval(context: AirwallexRiskContext) -> TimeInterval {
        context.environment == .production ? 20 : 5
    }
}

enum AirwallexKey {
    static let header = "x-risk-device-id"
    static let version = "version"
    static let simulatorModelIdentifier = "SIMULATOR_MODEL_IDENTIFIER"
    static let accept = "Accept"
    static let contentType = "Content-Type"
}

enum AirwallexUserDefaultKey {
    static let deviceID = "com.airwallex:deviceID"
    static let account = "com.airwallex:account"
    static let user = "com.airwallex:user"
    static let tenant = "com.airwallex:tenant"
    static let installationEvent = "com.airwallex:installevent"
}

enum AirwallexHost {
    static let production = "www.airwallex.com"
    static let demo = "demo.airwallex.com"
    static let staging = "staging.airwallex.com"
}
