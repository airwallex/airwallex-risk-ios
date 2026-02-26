//
//  AirwallexRisk.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

@objc(AWXRisk)
public class Risk: NSObject {
    private let context: AirwallexRiskContext
    private let eventManager: EventManagerType

    init(
        context: AirwallexRiskContext,
        eventManager: EventManagerType
    ) {
        self.context = context
        self.eventManager = eventManager
    }

    /// Airwallex risk request header.
    ///
    /// This header should be attached to each request made to `www.airwallex.com`.
    var header: Header {
        .init(
            field: AirwallexKey.header,
            value: context.deviceID.wrappedValue.uuidString
        )
    }
    
    /// Airwallex session ID. Unique per app run.
    var sessionID: UUID {
        context.sessionID
    }

    /// Sets the Airwallex  account ID.
    ///
    /// Use this method to update the account ID if it changes.
    /// - Parameters:
    ///   - accountID: Airwallex account ID. Set `nil` on sign out.
    func set(accountID: String?) {
        guard context.tenant == .scale else {
            context.update(accountID: accountID)
            return
        }
        let existingAccountID = context.account.wrappedValue.id
        // If same value, do nothing
        guard accountID != existingAccountID else { return }
        // Send logout event before context update if there's an existing account
        if existingAccountID != nil {
            eventManager.queue(
                event: .init(
                    type: .automatic(event: .accountLogout),
                    context: context
                )
            )
        }
        context.update(accountID: accountID)
        // Send login event after update if there's a new account
        if accountID != nil {
            eventManager.queue(
                event: .init(
                    type: .automatic(event: .accountLogin),
                    context: context
                )
            )
        }
    }

    /// Sets the signed in Airwallex  user ID.
    ///
    /// Use this method after user sign in/out to store the user ID to be sent with events.
    /// - Parameters:
    ///   - userID: Signed in Airwallex user ID. Set `nil` on sign out.
    func set(userID: String?) {
        let existingUserID = context.user.wrappedValue.id
        // If same value, do nothing
        guard userID != existingUserID else { return }
        // Send logout event before context update if there's an existing user
        if existingUserID != nil {
            eventManager.queue(
                event: .init(
                    type: .automatic(event: .userLogout),
                    context: context
                )
            )
        }
        context.update(userID: userID)
        // Send login event after update if there's a new user
        if userID != nil {
            eventManager.queue(
                event: .init(
                    type: .automatic(event: .userLogin),
                    context: context
                )
            )
        }
    }

    /// Adds a new event to the queue.
    ///
    /// This is a public method for client apps to log specific lifecycle events, eg. login, logout.
    /// - Parameters:
    ///   - event: App event that triggered this method call.
    ///   - screen: Current app view. Optional.
    func log(
        event: String,
        screen: String? = nil
    ) {
        eventManager.queue(
            event: .init(
                type: .custom(event: event),
                path: screen,
                context: context
            )
        )
    }
    
    /// Adds a new event to the queue.
    ///
    /// This is a public method for client apps to log specific lifecycle events, eg. login, logout.
    /// - Parameters:
    ///   - event: App event that triggered this method call.
    ///   - screen: Current app view. Optional.
    func log(
        event: Events,
        screen: String? = nil
    ) {
        eventManager.queue(
            event: .init(
                type: .custom(event: event.rawValue),
                path: screen,
                context: context
            )
        )
    }
}
