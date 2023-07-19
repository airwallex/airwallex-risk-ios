//
//  EventRepository.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 12/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

class EventRepository: RepositoryType {
    private var events: [Event] = .init()

    func add(_ item: Event) {
        self.events.append(item)
    }

    func add(_ items: [Event]) {
        self.events.insert(contentsOf: items, at: .zero)
    }

    func get() -> [Event] {
        events
    }

    func popAll() -> [Event]? {
        defer { removeAll() }
        return events.isEmpty ? nil : events
    }

    private func removeAll() {
        self.events = .init()
    }
}
