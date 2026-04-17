//
//  AirwallexRiskEnvironment.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

@objc public enum AirwallexRiskEnvironment: Int {
    case production
    case demo
    case staging
    case preview

    var host: String {
        switch self {
        case .production:
            return AirwallexHost.production
        case .demo:
            return AirwallexHost.demo
        case .staging:
            return AirwallexHost.staging
        case .preview:
            return AirwallexHost.preview
        }
    }
}
