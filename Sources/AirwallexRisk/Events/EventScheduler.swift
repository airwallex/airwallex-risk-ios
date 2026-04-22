//
//  EventScheduler.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 18/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

protocol EventSchedulerType {
    func scheduleRepeating(block: @escaping () async -> Void)
    func cancel()
}

class EventScheduler: EventSchedulerType {
    private let timeInterval: TimeInterval
    private var task: Task<Void, Never>?

    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    func scheduleRepeating(block: @escaping () async -> Void) {
        task?.cancel()
        task = Task {
            while !Task.isCancelled {
                await block()
                let interval = UInt64(timeInterval * 1_000_000_000)
                try? await Task.sleep(nanoseconds: interval)
            }
        }
    }

    func cancel() {
        task?.cancel()
        task = nil
    }

    deinit {
        task?.cancel()
    }
}
