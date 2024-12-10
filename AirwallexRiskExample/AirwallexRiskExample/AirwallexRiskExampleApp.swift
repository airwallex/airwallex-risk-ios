//
//  AirwallexRiskExampleApp.swift
//  AirwallexRiskExample
//
//  Created by Richie Shilton on 26/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import SwiftUI
import AirwallexRisk

@main
struct AirwallexRiskExampleApp: App {
    init() {
        Risk.start(
            accountID: "YOUR_ACCOUNT_ID",
            with: .init(isProduction: false)
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
