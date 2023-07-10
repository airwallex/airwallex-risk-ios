//
//  AirwallexRisk.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

public class AirwallexRisk {
    static var shared: AirwallexRisk = .init()

    var context: AirwallexRiskContext?

    init() { }

    /// Must be called once as early as possible in the app lifecycle.
    /// Optional configuration.
    ///
    public static func start(
        with configuration: AirwallexRiskConfiguration = .init()
    ) {
        guard shared.context == nil else {
            print("AirwallexRisk has already started.")
            return
        }
        shared.context = .init(
            environment: configuration.environment,
            tenant: configuration.tenant
        )

        print(
        """
        Airwallex Risk started with context:
        App name: \(String(describing: shared.context!.app.name))
        Environment: \(String(describing: shared.context!.environment))
        Tenant: \(shared.context!.tenant.rawValue)
        DeviceID: \(shared.context!.device.id)
        SessionID: \(shared.context!.sessionID)
        """
        )
    }

    /// Configure the Airwallex user information when available.
    /// This will be persisted until the next function call. Send `nil` to clear.
    ///
    public static func set(
        accountID: UUID?,
        userID: UUID?
    ) {
        shared.context?.user = .init(
            accountID: accountID,
            userID: userID
        )
    }
}
