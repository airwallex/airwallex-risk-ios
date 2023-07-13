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
            let preferredLanguage: String?
            let region: String?
            let name: String
            let version: String
        }
        struct Model: Codable, Equatable {
            let name: String?
        }
        let os: OS
        let model: Model
        let timezone: String?
        let brand: String?
        let screenSize: String
        let pixelDensity: String
        let batteryLevel: String
        let batteryState: String
        let storageCapacity: String
    }
}

extension Event.Device {
    init(device: Device) {
        self.os = .init(
                preferredLanguage: device.language,
                region: device.region,
                name: device.osName,
                version: device.osVersion
            )
        self.model = .init(
                name: device.model
            )
        self.timezone = device.timezone
        self.brand = device.modelBrand
        self.screenSize = device.screenSize
        self.pixelDensity = device.pixelDensity
        self.batteryLevel = device.batteryLevel
        self.batteryState = device.batteryState
        self.storageCapacity = device.storageCapacity
    }
}
