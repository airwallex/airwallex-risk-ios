//
//  AirwallexRiskConfiguration.swift
//  
//
//  Created by Richie Shilton on 7/7/2023.
//

import Foundation

/// AirwallexRisk configuration. Can be passed in as a parameter of ``AirwallexRisk/AirwallexRisk/start(accountID:with:)`` to configure the SDK.
@objc public class AirwallexRiskConfiguration: NSObject {
    let environment: AirwallexRiskEnvironment
    let tenant: Tenant
    let bufferTimeInterval: TimeInterval

    /// AirwallexRisk configuration options.
    ///
    /// Assigned when starting the SDK with ``AirwallexRisk/AirwallexRisk/start(accountID:with:)``.
    /// - Parameters:
    ///   - isProduction: Set to false for pre-production or test builds.
    ///   - tenant: Do not modify unless requested by Airwallex.
    public convenience init(
        isProduction: Bool = true,
        tenant: Tenant = .scale
    ) {
        self.init(environment: isProduction ? .production : .demo, tenant: tenant)
    }
    
    /// AirwallexRisk configuration options.
    ///
    /// Assigned when starting the SDK with ``AirwallexRisk/AirwallexRisk/start(accountID:with:)``.
    /// - Parameters:
    ///   - environment: Airwallex risk environment, set to production for release builds.
    ///   - tenant: Airwallex risk SDK tenant.
    public init(
        environment: AirwallexRiskEnvironment = .production,
        tenant: Tenant = .scale,
        bufferTimeInterval: TimeInterval = 20
    ) {
        self.environment = environment
        self.tenant = tenant
        self.bufferTimeInterval = bufferTimeInterval
    }
}
