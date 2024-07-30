//
//  Tenant.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 6/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

/// Airwallex risk SDK tenant. Do not modify unless requested by Airwallex.
@objc public enum Tenant: Int, Codable {
    /// Reserved for the Airwallex mobile app.
    case `internal`
    /// Use with the Airwallex payment SDK.
    case pa
    /// Default tenant for most users.
    case scale
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        let tenant = switch self {
        case .internal:
            "Mobile app"
        case .pa:
            "PA checkout"
        case .scale:
            "Scale"
        }
        try container.encode(tenant)
    }
}
