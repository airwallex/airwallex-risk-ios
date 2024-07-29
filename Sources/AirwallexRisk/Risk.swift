//
//  AirwallexRisk.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

public class Risk {
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
        context.update(accountID: accountID)
    }

    /// Sets the signed in Airwallex  user ID.
    ///
    /// Use this method after user sign in/out to store the user ID to be sent with events.
    /// - Parameters:
    ///   - userID: Signed in Airwallex user ID. Set `nil` on sign out.
    func set(userID: String?) {
        context.update(userID: userID)
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
}
