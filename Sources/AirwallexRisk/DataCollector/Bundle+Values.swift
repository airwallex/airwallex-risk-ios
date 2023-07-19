//
//  Bundle+Values.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension Bundle {
    enum Key: String {
        case appName = "CFBundleName"
        case version = "CFBundleShortVersionString"
        case build = "CFBundleVersion"
    }

    static func appValue(for key: Key) -> String? {
        main.infoDictionary?[key.rawValue] as? String
    }

    static var sdkVersion: String? {
        guard let path = Bundle.module.path(forResource: AirwallexKey.version, ofType: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            return result?[AirwallexKey.version]
        } catch {
            return nil
        }
    }
}
