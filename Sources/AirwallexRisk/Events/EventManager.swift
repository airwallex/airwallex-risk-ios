//
//  EventManager.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 10/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

protocol EventManagerType {
    func queue(event: Event)
    func sendEvents() async
    func scheduleEvents()
}

class EventManager: EventManagerType {
    private let repository: any RepositoryType<Event>
    private let client: ClientType
    private let eventScheduler: EventSchedulerType
    private let automaticEventProvider: AutomaticEventProviderType

    convenience init(
        context: AirwallexRiskContext,
        repository: any RepositoryType<Event> = EventRepository(),
        session: URLSession = .shared,
        timeInterval: TimeInterval
    ) {
        self.init(
            repository: repository,
            client: AirwallexRiskClient(
                session: session,
                context: context
            ),
            eventScheduler: EventScheduler(
                timeInterval: timeInterval
            ),
            automaticEventProvider: AutomaticEventProvider(
                repository: repository,
                context: context
            )
        )
        self.automaticEventProvider.openEvent()
        self.scheduleEvents()
    }

    init(
        repository: any RepositoryType<Event>,
        client: ClientType,
        eventScheduler: EventSchedulerType,
        automaticEventProvider: AutomaticEventProviderType
    ) {
        self.repository = repository
        self.client = client
        self.eventScheduler = eventScheduler
        self.automaticEventProvider = automaticEventProvider
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

    func scheduleEvents() {
        eventScheduler.scheduleRepeating(block: sendEvents)
    }
}
