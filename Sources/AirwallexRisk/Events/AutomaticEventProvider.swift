//
//  AutomaticEventProvider.swift
//  
//
//  Created by Richie Shilton on 18/7/2023.
//

import Foundation

class AutomaticEventProvider {
    private let repository: EventRepository
    private let context: AirwallexRiskContext

    init(
        repository: EventRepository,
        context: AirwallexRiskContext
    ) {
        self.repository = repository
        self.context = context

        self.onStart()
    }

    private func onStart() {
        let type: EventType.SDKEvent = context.shouldSendInstallationEvent ? .installation : .open
        queue(.automatic(event: type))
    }

    private func queue(_ type: EventType) {
        repository.add(.init(type: type, context: context))
    }
}
