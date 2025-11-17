//
//  AirwallexRisk+Shared.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 14/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension Risk {
    /// Shared instance of ``Risk``.
    private static var shared: Risk?

    /// Starts the shared ``Risk`` SDK instance.
    ///
    /// - Parameters:
    ///   - accountID: Airwallex account ID for app customer. Required for all scale customers.
    ///   - configuration: ``AirwallexRiskConfiguration`` can be passed in if additional configuration is needed. Set `isProduction` to `false` for test builds.
    /// - Remark: Must be called once, as early as possible in the apps lifecycle.
    @objc public static func start(
        accountID: String?,
        with configuration: AirwallexRiskConfiguration = .init()
    ) {
        guard shared == nil else {
            print("AirwallexRisk has already started.")
            return
        }
        let context = AirwallexRiskContext.init(
            accountID: accountID,
            environment: configuration.environment,
            tenant: configuration.tenant
        )
        shared = .init(
            context: context,
            eventManager: EventManager(
                context: context,
                timeInterval: configuration.bufferTimeInterval
            )
        )
    }

    /// Updates the  Airwallex  account ID in the shared instance.
    ///
    /// Use this method if the account ID changes after calling ``start(accountID:with:)``. This method is unneeded by most users.
    /// - Parameters:
    ///   - accountID: Airwallex account ID. Set `nil` if unavailable.
    @objc public static func set(accountID: String?) {
        guard let shared else {
            print(AirwallexValue.notStartedWarning)
            return
        }
        shared.set(accountID: accountID)
    }

    /// Stores the signed in Airwallex  user ID in the shared instance.
    ///
    /// Use this method after user sign in/out to store the user ID to be sent with events.
    /// - Parameters:
    ///   - userID: Signed in Airwallex user ID. Set `nil` on sign out.
    @objc public static func set(userID: String?) {
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
    @objc public static func log(
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
    
    /// Airwallex session ID. Unique per app run.
    @objc public static var sessionID: UUID? {
        guard let shared else {
            print(AirwallexValue.notStartedWarning)
            return nil
        }
        return shared.sessionID
    }
}

public extension Risk {
    
    /// Standardized event names used across integrations.
    enum Events: RawRepresentable, Equatable {

        /// User starts a new transaction flow
        /// Use when user begins any payment/transfer process, before entering details
        case transactionInitiated
        
        /// User accessed/viewed card PIN
        /// Use when user successfully views their card PIN through app
        case cardPinViewed

        /// User accessed/viewed card CVC/CVV
        /// Use when user successfully views their card CVC/security code
        case cardCvcViewed

        /// User changed their phone number
        /// Use when phone number change is successfully saved
        case profilePhoneUpdated

        /// User changed their email address
        /// Use when email change is successfully saved
        case profileEmailUpdated

        /// A catch-all for any non-standard or integration-specific event names.
        /// Naming convention of the associated will be snake_case and past tense for completed actions (`viewed`, `updated`, `initiated`)
        case other(String)

        // MARK: RawRepresentable
        
        public var rawValue: String {
            switch self {
            case .transactionInitiated:
                return "transaction_initiated"
            case .cardPinViewed:
                return "card_pin_viewed"
            case .cardCvcViewed:
                return "card_cvc_viewed"
            case .profilePhoneUpdated:
                return "profile_phone_updated"
            case .profileEmailUpdated:
                return "profile_email_updated"
            case .other(let name):
                return name
            }
        }
        
        public init?(rawValue: String) {
            switch rawValue {
            case Self.transactionInitiated.rawValue:
                self = .transactionInitiated
            case Self.cardPinViewed.rawValue:
                self = .cardPinViewed
            case Self.cardCvcViewed.rawValue:
                self = .cardCvcViewed
            case Self.profilePhoneUpdated.rawValue:
                self = .profilePhoneUpdated
            case Self.profileEmailUpdated.rawValue:
                self = .profileEmailUpdated
            default:
                self = .other(rawValue)
            }
        }
    }
    
    /// Adds a new event to the queue.
    ///
    /// This is a public method for client apps to log specific lifecycle events, eg. login, logout.
    /// - Parameters:
    ///   - event: App event that triggered this method call.
    ///   - screen: Current app view. Optional.
    static func log(
        event: Events,
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
}
