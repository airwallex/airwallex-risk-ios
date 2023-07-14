//
//  EventDevice.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 13/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension Event {
    struct Device: Codable, Equatable {
        // swiftlint:disable:next type_name
        struct OS: Codable, Equatable {
            let language: String?
            let region: String?
            let timezone: String?
            let name: String
            let version: String
        }
        struct Model: Codable, Equatable {
            let name: String?
            let brand: String?
        }
        let os: OS
        let model: Model
    }
}

extension Event.Device {
    init(device: Device) {
        self.os = .init(
            language: device.language,
            region: device.region,
            timezone: device.timezone,
            name: device.osName,
            version: device.osVersion
        )
        self.model = .init(
            name: device.modelName,
            brand: device.modelBrand
        )
    }
}
