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
    /// - Parameters:
    ///   - accountID: Airwallex account ID for app customer. Required for all scale customers.
    ///   - configuration: ``AirwallexRiskConfiguration`` can be passed in if additional configuration is needed.
    /// - Remark: Must be called once, as early as possible in the apps lifecycle.
    public static func start(
        accountID: String?,
        with configuration: AirwallexRiskConfiguration = .init()
    ) {
        guard shared.context == nil else {
            print("AirwallexRisk has already started.")
            return
        }
        shared.context = .init(
            accountID: accountID,
            environment: configuration.environment,
            tenant: configuration.tenant
        )

        shared.eventManager = .init()
    }

    /// Stores the signed in Airwallex  user ID.
    ///
    /// Use this method after user sign in/out to store the user ID to be sent with events.
    /// - Parameters:
    ///   - userID: Signed in Airwallex user ID. Set `nil` on sign out.
    public static func set(userID: String?) {
        guard let context = shared.context else {
            print(AirwallexValue.notStartedWarning)
            return
        }
        context.update(
            user: .init(userID: userID)
        )
    }

    /// Add a new event to the queue.
    ///
    /// This is a public method for client apps to log specific lifecycle events, eg. login, logout.
    /// - Parameters:
    ///   - event: App event that triggered this method call.
    ///   - screen: Current app view. Optional.
    public static func log(
        event: AppEventType,
        screen: String? = nil
    ) {
        guard let eventManager = shared.eventManager,
              let context = shared.context else {
            print(AirwallexValue.notStartedWarning)
            return
        }
        eventManager.queue(
            event: .init(
                type: .app(event: event),
                path: screen,
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
