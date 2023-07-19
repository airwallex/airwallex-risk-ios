//
//  AirwallexRiskContext.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

class AirwallexRiskContext {
    private(set) var deviceID: Storage<UUID>
    private(set) var account: Storage<AirwallexID>
    private(set) var user: Storage<AirwallexID>
    let environment: AirwallexRiskEnvironment
    let tenant: Tenant
    let sessionID: UUID
    let dataCollector: DataCollector
    let defaults: UserDefaults?

    init(
        accountID: String?,
        environment: AirwallexRiskEnvironment,
        tenant: Tenant,
        defaults: UserDefaults? = .sdk
    ) {
        self.deviceID = .init(
            key: AirwallexUserDefaultKey.deviceID,
            defaults: defaults
        )
        self.account = .init(
            key: AirwallexUserDefaultKey.account,
            defaults: defaults
        )
        if let accountID {
            self.account.wrappedValue = .init(id: accountID)
        }
        self.user = .init(
            key: AirwallexUserDefaultKey.user,
            defaults: defaults
        )
        self.environment = environment
        self.tenant = tenant
        self.sessionID = .init()
        self.dataCollector = .init(
            app: .init(),
            device: .init()
        )
        self.defaults = defaults
    }

    var shouldSendInstallationEvent: Bool {
        let key = AirwallexUserDefaultKey.installationEvent
        if let defaults, !defaults.bool(forKey: key) {
            defaults.set(true, forKey: key)
            return true
        }
        return false
    }

    func update(accountID: String?) {
        self.account.wrappedValue = .init(id: accountID)
    }

    func update(userID: String?) {
        self.user.wrappedValue = .init(id: userID)
    }
}
