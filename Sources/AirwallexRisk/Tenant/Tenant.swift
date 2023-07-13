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
    case `internal` = "mobile-app"
    /// Default tenant for most users.
    case scale = "scale"
}
