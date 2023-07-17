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
    private(set) var account: Storage<Account>
    private(set) var user: Storage<User>
    let environment: AirwallexRiskEnvironment
    let tenant: Tenant
    let sessionID: UUID
    let dataCollector: DataCollector

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
        self.account.wrappedValue = .init(id: accountID)
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

        print("+++ Context +++\n\(description)\n")
    }

    var description: String {
        """
        App name: \(dataCollector.app.name ?? "unknown")
        AccountID: \(String(describing: account.wrappedValue.id))
        Environment: \(String(describing: environment))
        Tenant: \(tenant.rawValue)
        DeviceID: \(deviceID)
        SessionID: \(sessionID)
        """
    }

    func update(account: Account) {
        self.account.wrappedValue = account
    }

    func update(user: User) {
        self.user.wrappedValue = user
    }
}
