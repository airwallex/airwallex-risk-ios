//
//  EventManager.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 10/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

class EventManager {
    let repository: EventRepository

    init() {
        self.repository = .init()
    }

    func queue(event: Event) {
        repository.add(event: event)
    }
}
