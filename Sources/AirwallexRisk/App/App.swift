//
//  App.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
import UIKit

struct App {

    /// Obtain the app name.
    ///
    /// Example of return values
    ///  - `"Airwallex"
    var name: String? {
        Bundle.appValue(for: .appName)
    }

    /// Obtain the app version.
    ///
    /// Example of return values
    ///  - `"2.60.0"
    var version: String? {
        Bundle.appValue(for: .version)
    }

    /// Obtain the app build.
    ///
    /// Example of return values
    ///  - `"123"
    var build: String? {
        Bundle.appValue(for: .build)
    }

    /// Obtain the localised app language. This indicate the language (of text) the user is most likely seeing in the UI.
    ///
    /// Example of return values
    ///  - `"en"
    var language: String? {
        Bundle.main.preferredLocalizations.first
    }

    /// Determine if the app can be refreshed in the background.
    ///
    /// Example of return values
    ///  - `true`
    var isBackgroundEnabled: Bool {
        UIApplication.shared.isBackgroundEnabled
    }

    /// Obtain the Airwallex Risk SDK version.
    ///
    /// Example of return values
    ///  - `"1.0.0"
    var sdkVersion: String? {
        Bundle.version
    }
}
