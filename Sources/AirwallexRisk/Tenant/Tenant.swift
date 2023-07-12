//
//  Tenant.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 6/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

/// Airwallex risk SDK tenant. Do not modify unless requested by Airwallex.
public enum Tenant: String, Codable {
    /// Reserved for the Airwallex mobile app.
    case airwallexMobile = "mobile-app"
    /// Use with the Airwallex payment SDK.
    case pa = "pa-checkout"
    /// Default tenant.
    case scale = "scale"
}
