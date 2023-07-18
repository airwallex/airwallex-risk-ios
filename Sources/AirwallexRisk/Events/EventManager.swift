//
//  EventManager.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 10/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

class EventManager {
    private let repository: EventRepository
    private let client: AirwallexRiskClient
    private let eventScheduler: EventScheduler

    init(
        context: AirwallexRiskContext,
        repository: EventRepository = .init(),
        session: URLSession = .shared
    ) {
        self.repository = repository
        self.client = .init(
            session: session,
            context: context
        )
        self.eventScheduler = .init(timeInterval: AirwallexValue.timeInterval(context: context))

        self.scheduleEvents()

    }

    func queue(event: Event) {
        repository.add(event)
    }

    func sendEvents() async {
        guard let events = repository.popAll() else {
            return
        }
        do {
            try await client.log(events: events)
        } catch {
            // On error, push the events back on the queue for retrying.
            repository.add(events)
        }
    }

    private func scheduleEvents() {
        eventScheduler.scheduleRepeating(block: sendEvents)
    }
}
