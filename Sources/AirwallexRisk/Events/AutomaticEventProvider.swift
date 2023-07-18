//
//  AutomaticEventProvider.swift
//  
//
//  Created by Richie Shilton on 18/7/2023.
//

import Foundation

protocol AutomaticEventProviderType {
    func openEvent()
}

class AutomaticEventProvider: AutomaticEventProviderType {
    private let repository: any RepositoryType<Event>
    private let context: AirwallexRiskContext

    init(
        repository: any RepositoryType<Event>,
        context: AirwallexRiskContext
    ) {
        self.repository = repository
        self.context = context
    }

    func openEvent() {
        let type: EventType.SDKEvent = context.shouldSendInstallationEvent ? .installation : .open
        queue(.automatic(event: type))
    }

    private func queue(_ type: EventType) {
        repository.add(.init(type: type, context: context))
    }
}
