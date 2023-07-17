//
//  AirwallexRisk.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

public class AirwallexRisk {
    private let context: AirwallexRiskContext
    private let eventManager: EventManager

    init(
        context: AirwallexRiskContext,
        eventManager: EventManager
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

    /// Sets the Airwallex  account ID.
    ///
    /// Use this method to update the account ID if it changes. 
    /// - Parameters:
    ///   - accountID: Airwallex account ID. Set `nil` on sign out.
    func set(accountID: String?) {
        context.update(
            account: .init(id: accountID)
        )
    }

    /// Sets the signed in Airwallex  user ID.
    ///
    /// Use this method after user sign in/out to store the user ID to be sent with events.
    /// - Parameters:
    ///   - userID: Signed in Airwallex user ID. Set `nil` on sign out.
    func set(userID: String?) {
        context.update(
            user: .init(id: userID)
        )
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
