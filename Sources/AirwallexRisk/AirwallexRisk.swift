//
//  AirwallexRisk.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

public class AirwallexRisk {
    let context: AirwallexRiskContext
    let eventManager: EventManager

    init(
        context: AirwallexRiskContext,
        eventManager: EventManager
    ) {
        self.context = context
        self.eventManager = eventManager
    }

    /// Stores the signed in Airwallex  user ID.
    ///
    /// Use this method after user sign in/out to store the user ID to be sent with events.
    /// - Parameters:
    ///   - userID: Signed in Airwallex user ID. Set `nil` on sign out.
    func set(userID: String?) {
        context.update(
            user: .init(userID: userID)
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
