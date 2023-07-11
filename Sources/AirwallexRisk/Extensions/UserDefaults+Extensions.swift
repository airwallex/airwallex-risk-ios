//
//  UserDefaults+Extensions.swift
//  
//
//  Created by Richie Shilton on 7/7/2023.
//

import Foundation

extension UserDefaults {
    private static let airwallexRiskSuiteName = "com.airwallex.risk-sdk"

    /// AirwallexRisk UserDefault instance.
    static var sdk = UserDefaults(suiteName: airwallexRiskSuiteName)
}
