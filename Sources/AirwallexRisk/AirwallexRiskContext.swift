//
//  AirwallexRiskContext.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

class AirwallexRiskContext {
    @Storage(key: AirwallexUserDefaultKey.deviceID, defaultValue: .init())
    private(set) var deviceID: UUID
    @Storage(key: AirwallexUserDefaultKey.user, defaultValue: .init())
    private(set) var user: User
    let environment: AirwallexRiskEnvironment
    let tenant: Tenant
    let sessionID: UUID
    let device: Device
    let app: App

    init(
        environment: AirwallexRiskEnvironment,
        tenant: Tenant
    ) {
        self.environment = environment
        self.tenant = tenant
        self.sessionID = .init()
        self.device = .init()
        self.app = .init()

        print("AirwallexRisk context:\n\(description)")
    }

    var description: String {
        """
        App name: \(app.name ?? "unknown")
        Environment: \(String(describing: environment))
        Tenant: \(tenant.rawValue)
        DeviceID: \(deviceID)
        SessionID: \(sessionID)
        """
    }

    func update(user: User) {
        self.user = user
    }
}
