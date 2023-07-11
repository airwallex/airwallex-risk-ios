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
    private(set) var context: AirwallexRiskContext?

    /// Start the `AirwallexRisk` SDK.
    ///
    /// - Parameter configuration: ``AirwallexRiskConfiguration`` can be passed in if additional configuration is needed.
    /// - Remark: Must be called once, as early as possible in the apps lifecycle.
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
    }

    /// Stores the signed in Airwallex account and user IDs.
    ///
    /// Use this method after user sign in/out to store the user properties to be sent with events.
    /// - Parameters:
    ///   - accountID: Signed in Airwallex account ID. Set `nil` when signed out.
    ///   - userID: Signed in Airwallex user ID. Set `nil` when signed out.
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
