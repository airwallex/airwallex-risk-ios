//
//  Device.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
import UIKit

struct Device {
    /// Per installation device identifier. Do not modify.
    @Storage(key: AirwallexUserDefaultKey.deviceID, defaultValue: .init())
    private(set) var id: UUID

    /// Device timezone.
    ///
    /// Example of return values
    ///  - `"Australia/Melbourne"`
    var timezone: String? {
        TimeZone.current.identifier
    }

    /// Device language.
    ///
    /// Example of return values
    ///  - `"en"`
    var language: String? {
        if #available(iOS 16, *) {
            return Locale.current.language.languageCode?.identifier
        } else {
            return Locale.current.languageCode
        }
    }

    /// Device region identifier.
    ///
    /// Example of return values
    ///  - `"US"`
    var countryISO: String? {
        if #available(iOS 16, *) {
            return Locale.current.language.region?.identifier
        } else {
            return Locale.current.regionCode
        }
    }

    /// Device operating system name.
    ///
    /// Example of return values
    ///  - `"iOS"`
    var osName: String {
        UIDevice.current.systemName
    }

    /// Device operating system version number.
    ///
    /// Example of return values
    ///  - `"16.4"`
    var osVersion: String {
        UIDevice.current.systemVersion
    }

    /// Device hardware model name.
    ///
    /// Example of return values
    ///  - `"iPhone8,1"` = iPhone 6s
    ///  - `"iPad6,7"` = iPad Pro (12.9-inch)
    var model: String {
        if let identifier = ProcessInfo().environment[AirwallexKey.simulatorModelIdentifier] {
            return "\(identifier) \(AirwallexValue.simulator)"
        }
        var utsnameInstance = utsname()
        uname(&utsnameInstance)
        guard let model = String(bytes: Data(bytes: &utsnameInstance.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii) else {
            return AirwallexValue.unknown
        }
        return model.trimmingCharacters(in: .controlCharacters)
    }

    /// Device brand.
    ///
    /// Example of return values
    ///  - `"Apple"`
    var modelBrand: String {
        AirwallexValue.apple
    }
}
