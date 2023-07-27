//
//  EventDetail.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 27/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension Event {
    struct Detail: Codable {
        let createdAtUTC: Date
        let type: EventType
        let screen: Screen
    }
}
