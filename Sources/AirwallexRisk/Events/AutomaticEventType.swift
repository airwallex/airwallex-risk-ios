//
//  AutomaticEventType.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 12/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

/// Automatically logged app lifecycle event type
enum AutomaticEventType: String, Codable {
    case firstLaunch
    case open
    case background
}
