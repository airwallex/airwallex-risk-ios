//
//  Device.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
#if !os(OSX)
import UIKit
#endif

#if os(watchOS)
import WatchKit
#endif


struct Device {
    /// Device language.
    ///
    /// Example of return values
    ///  - `"en"`
    var language: String? = {
        if #available(iOS 16, tvOS 16, watchOS 9, *) {
            return Locale.current.language.languageCode?.identifier
        } else {
            return Locale.current.languageCode
        }
    }()

    /// Device region identifier.
    ///
    /// Example of return values
    ///  - `"US"`
    var region: String? = {
        if #available(iOS 16, tvOS 16, watchOS 9, *) {
            return Locale.current.language.region?.identifier
        } else {
            return Locale.current.regionCode
        }
    }()

    /// Device timezone.
    ///
    /// Example of return values
    ///  - `"Australia/Melbourne"`
    var timezone: String? = {
        TimeZone.current.identifier
    }()

    /// Device operating system name.
    ///
    /// Example of return values
    ///  - `"iOS"`
    var osName: String = {
        #if os(iOS) || os(tvOS)
        return UIDevice.current.systemName
        #elseif os(watchOS)
        return "watchOS"
        #elseif os(OSX)
        return "macOS"
        #else
        return AirwallexValue.unknown
        #endif
    }()

    /// Device operating system version number.
    ///
    /// Example of return values
    ///  - `"16.4"`
    var osVersion: String = {
        #if os(iOS) || os(tvOS)
        return UIDevice.current.systemVersion
        #elseif os(watchOS)
        return WKInterfaceDevice.current().systemVersion
        #elseif os(OSX)
        return ProcessInfo.processInfo.operatingSystemVersionString
        #else
        return AirwallexValue.unknown
        #endif
    }()

    /// Device hardware model name.
    ///
    /// Example of return values
    ///  - `"iPhone8,1"` = iPhone 6s
    ///  - `"iPad6,7"` = iPad Pro (12.9-inch)
    var modelName: String = {
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
}
