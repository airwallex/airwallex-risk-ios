//
//  AirwallexRiskConfiguration.swift
//  
//
//  Created by Richie Shilton on 7/7/2023.
//

import Foundation

public struct AirwallexRiskConfiguration {
    let environment: AirwallexRiskEnvironment
    let tenant: Tenant

    /// AirwallexRisk configuration options.
    ///
    /// Assigned when starting the SDK with ``AirwallexRisk/AirwallexRisk/start(with:)``.
    /// - Parameters:
    ///   - isProduction: Set to false for pre-production or test builds.
    ///   - tenant: Do not modify unless requested by Airwallex.
    public init(
        isProduction: Bool = true,
        tenant: Tenant = .scale
    ) {
        self.environment = isProduction ? .production : .demo
        self.tenant = tenant
    }
}
