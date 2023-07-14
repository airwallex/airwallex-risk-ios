//
//  File.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 14/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension AirwallexRisk {
    private(set) static var shared: AirwallexRisk?

    /// Starts the shared `AirwallexRisk` SDK instance.
    ///
    /// - Parameters:
    ///   - accountID: Airwallex account ID for app customer. Required for all scale customers.
    ///   - configuration: ``AirwallexRiskConfiguration`` can be passed in if additional configuration is needed.
    /// - Remark: Must be called once, as early as possible in the apps lifecycle.
    public static func start(
        accountID: String?,
        with configuration: AirwallexRiskConfiguration = .init()
    ) {
        guard shared == nil else {
            print("AirwallexRisk has already started.")
            return
        }
        shared = .init(
            context: .init(
                accountID: accountID,
                environment: configuration.environment,
                tenant: configuration.tenant
            ),
            eventManager: .init()
        )
    }

    /// Stores the signed in Airwallex  user ID in the shared instance.
    ///
    /// Use this method after user sign in/out to store the user ID to be sent with events.
    /// - Parameters:
    ///   - userID: Signed in Airwallex user ID. Set `nil` on sign out.
    public static func set(userID: String?) {
        guard let shared else {
            print(AirwallexValue.notStartedWarning)
            return
        }
        shared.set(userID: userID)
    }

    /// Adds a new event to the queue.
    ///
    /// This is a public method for client apps to log specific lifecycle events, eg. login, logout.
    /// - Parameters:
    ///   - event: App event that triggered this method call.
    ///   - screen: Current app view. Optional.
    public static func log(
        event: String,
        screen: String? = nil
    ) {
        guard let shared else {
            print(AirwallexValue.notStartedWarning)
            return
        }
        shared.log(
            event: event,
            screen: screen
        )
    }

    /// Airwallex risk request header.
    ///
    /// This header should be attached to each request made to `www.airwallex.com`.
    /// - Note: You can directly attach this header to a request with the `URLRequest` extension method `setAirwallexHeader()`.
    public static var header: Header? {
        guard let shared else {
            print(AirwallexValue.notStartedWarning)
            return nil
        }
        return shared.header
    }

    /// Stops the `AirwallexRisk` SDK.
    static func stop() {
        shared = nil
    }
}
