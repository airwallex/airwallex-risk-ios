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
    /// Per installation device identifier. Do not update.
    @Storage(key: AirwallexUserDefaultKey.deviceID, defaultValue: .init())
    private(set) var id: UUID

    /// Obtain the devices timezone.
    ///
    /// Example of return values
    ///  - `"Australia/Melbourne"
    var timezone: String? {
        TimeZone.current.identifier
    }

    /// Obtain the devices language.
    ///
    /// Example of return values
    ///  - `"en"
    var language: String? {
        if #available(iOS 16, *) {
            return Locale.current.language.languageCode?.identifier
        } else {
            return Locale.current.languageCode
        }
    }

    /// Obtain the devices region identifier.
    ///
    /// Example of return values
    ///  - `"US"
    var countryISO: String? {
        if #available(iOS 16, *) {
            return Locale.current.language.region?.identifier
        } else {
            return Locale.current.regionCode
        }
    }

    /// Obtain the operating system name.
    ///
    /// Example of return values
    ///  - `"iOS"
    var osName: String {
        UIDevice.current.systemName
    }

    /// Obtain the operating system version number.
    ///
    /// Example of return values
    ///  - `"16.4"
    var osVersion: String {
        UIDevice.current.systemVersion
    }

    /// Obtain the hardware model name.
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

    /// Obtain the devices brand.
    ///
    /// Example of return values
    ///  - `"Apple"
    var modelBrand: String {
        AirwallexValue.apple
    }
}
