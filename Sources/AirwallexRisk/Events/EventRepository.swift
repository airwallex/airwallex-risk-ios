//
//  EventRepository.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 12/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

class EventRepository {
    private(set) var events: [Event] = .init()

    func add(event: Event) {
        events.append(event)
    }

    func remove(event: Event) {
        remove(event: event.eventID)
    }

    func remove(event id: UUID) {
        events.removeAll(where: { $0.eventID == id })
    }

    func removeAll() {
        events = .init()
    }
}
