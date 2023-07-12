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
    private(set) var eventManager: EventManager?

    /// Start the `AirwallexRisk` SDK.
    ///
    /// - Parameter configuration: ``AirwallexRiskConfiguration`` can be passed in if additional configuration is needed.
    /// - Remark: Must be called once, as early as possible in the apps lifecycle.
    public static func start(with configuration: AirwallexRiskConfiguration = .init()) {
        guard shared.context == nil else {
            print("AirwallexRisk has already started.")
            return
        }
        shared.context = .init(
            environment: configuration.environment,
            tenant: configuration.tenant
        )

        shared.eventManager = .init()
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
        guard let context = shared.context else {
            print(AirwallexValue.notStartedWarning)
            return
        }
        context.update(
            user: .init(
                accountID: accountID,
                userID: userID
            )
        )
    }

    /// Add a new event to the queue.
    ///
    /// This is a public method for client apps to log specific lifecycle events, eg. login, logout.
    /// - Parameter event: Event type.
    public static func log(event: AppEventType) {
        guard let eventManager = shared.eventManager,
              let context = shared.context else {
            print(AirwallexValue.notStartedWarning)
            return
        }
        eventManager.queue(
            event: .init(
                type: .app(event: event),
                context: context
            )
        )
    }

    /// Stops the `AirwallexRisk` SDK.
    static func stop() {
        shared.context = nil
        shared.eventManager = nil
    }
}
