//
//  EventApp.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 13/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension Event {
    struct App: Codable, Equatable {
        struct SDK: Codable, Equatable {
            let version: String?
        }
        let name: String?
        let version: String?
        let language: String?
        let sdk: SDK
    }
}

extension Event.App {
    init(app: App) {
        self.name = app.name
        self.version = app.version
        self.language = app.language
        self.sdk = .init(version: app.sdkVersion)
    }
}
