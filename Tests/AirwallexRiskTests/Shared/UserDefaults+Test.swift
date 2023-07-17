//
//  File.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
@testable import AirwallexRisk

extension UserDefaults {
    static var test: UserDefaults? {
        UserDefaults(suiteName: UUID().uuidString)
    }

    static func clearSDKUserDefaults() {
        UserDefaults.sdk?.removePersistentDomain(forName: "com.airwallex.risk-sdk")
    }
}
