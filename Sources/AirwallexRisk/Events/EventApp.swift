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
        let name: String?
        let version: String?
        let build: String?
        let language: String?
        let isBackgroundEnabled: Bool
        let sdkVersion: String?
    }
}

extension Event.App {
    init(app: App) {
        self.name = app.name
        self.version = app.version
        self.build = app.build
        self.language = app.language
        self.isBackgroundEnabled = app.isBackgroundEnabled
        self.sdkVersion = app.sdkVersion
    }
}
