//
//  AppEventType.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 12/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

/// App lifecycle event type.
public enum AppEventType: String, Codable {
    case login
    case logout
}
