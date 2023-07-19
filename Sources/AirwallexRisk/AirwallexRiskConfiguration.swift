//
//  AirwallexRiskConfiguration.swift
//  
//
//  Created by Richie Shilton on 7/7/2023.
//

import Foundation

/// AirwallexRisk configuration. Can be passed in as a parameter of ``AirwallexRisk/AirwallexRisk/start(accountID:with:)`` to configure the SDK.
public struct AirwallexRiskConfiguration {
    let environment: AirwallexRiskEnvironment
    let tenant: Tenant

    /// AirwallexRisk configuration options.
    ///
    /// Assigned when starting the SDK with ``AirwallexRisk/AirwallexRisk/start(accountID:with:)``.
    /// - Parameters:
    ///   - isProduction: Set to false for pre-production or test builds.
    ///   - tenant: Do not modify unless requested by Airwallex.
    public init(
        isProduction: Bool = true,
        tenant: Tenant = .scale
    ) {
        self.environment = isProduction ? .production : .staging
        self.tenant = tenant
    }
}
