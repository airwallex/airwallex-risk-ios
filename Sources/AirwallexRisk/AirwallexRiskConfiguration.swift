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

    /// AirwallexRisk Options
    /// Set `isProduction` to `false` for test environments.
    /// **Only modify** the tenant value if requested by Airwallex.
    public init(
        isProduction: Bool = true,
        tenant: Tenant = .scale
    ) {
        self.environment = isProduction ? .production : .demo
        self.tenant = tenant
    }
}
