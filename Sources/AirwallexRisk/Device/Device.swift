//
//  Device.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
import UIKit

struct Device: Codable, Equatable {
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }

    /// Device timezone.
    ///
    /// Example of return values
    ///  - `"Australia/Melbourne"`
    var timezone: String? = {
        TimeZone.current.identifier
    }()

    /// Device language.
    ///
    /// Example of return values
    ///  - `"en"`
    var language: String? = {
        if #available(iOS 16, *) {
            return Locale.current.language.languageCode?.identifier
        } else {
            return Locale.current.languageCode
        }
    }()

    /// Device region identifier.
    ///
    /// Example of return values
    ///  - `"US"`
    var countryISO: String? = {
        if #available(iOS 16, *) {
            return Locale.current.language.region?.identifier
        } else {
            return Locale.current.regionCode
        }
    }()

    /// Device operating system name.
    ///
    /// Example of return values
    ///  - `"iOS"`
    var osName: String = {
        UIDevice.current.systemName
    }()

    /// Device operating system version number.
    ///
    /// Example of return values
    ///  - `"16.4"`
    var osVersion: String = {
        UIDevice.current.systemVersion
    }()

    /// Device hardware model name.
    ///
    /// Example of return values
    ///  - `"iPhone8,1"` = iPhone 6s
    ///  - `"iPad6,7"` = iPad Pro (12.9-inch)
    var model: String = {
        if let identifier = ProcessInfo().environment[AirwallexKey.simulatorModelIdentifier] {
            return "\(identifier) \(AirwallexValue.simulator)"
        }
        var utsnameInstance = utsname()
        uname(&utsnameInstance)
        guard let model = String(bytes: Data(bytes: &utsnameInstance.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii) else {
            return AirwallexValue.unknown
        }
        return model.trimmingCharacters(in: .controlCharacters)
    }()

    /// Device brand.
    ///
    /// Example of return values
    ///  - `"Apple"`
    var modelBrand: String = {
        AirwallexValue.apple
    }()

    /// Device screen size.
    ///
    /// Example of return values
    ///  - `"375.0x812.0"`
    var screenSize: String {
        let screen = UIScreen.main.bounds
        return "\(screen.width)X\(screen.height)"
    }

    /// Device  natural scale factor associated with the screen.
    ///
    /// Example of return values
    ///  - `"3.0"`
    var pixelDensity: String {
        String(describing: UIScreen.main.scale)
    }

    /// Current battery level of device as a value between 0.0 (flat) and 1.0 (fully charged)
    ///
    /// Example of return values
    ///  - `"0.9"`
    var batteryLevel: String {
        String(describing: UIDevice.current.batteryLevel)
    }

    /// Current battery charging state
    ///
    /// Example of return values
    ///  - `"charging"`
    var batteryState: String {
        switch UIDevice.current.batteryState {
        case .unplugged: return "unplugged"
        case .charging: return "charging"
        case .full: return "full"
        default: return AirwallexValue.unknown
        }
    }

    /// Available device storage capacity in bytes.
    ///
    /// Example of return values
    ///  - `"236430798848"`
    var storageCapacity: String {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory() as String)
        let values = try? fileURL.resourceValues(forKeys: [.volumeAvailableCapacityKey])
        guard let capacity = values?.volumeAvailableCapacity else {
            return AirwallexValue.unknown
        }
        return String(describing: capacity)
    }
}
