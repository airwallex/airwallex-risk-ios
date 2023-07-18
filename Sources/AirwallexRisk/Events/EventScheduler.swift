//
//  EventScheduler.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 18/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

class EventScheduler {
    private let timeInterval: TimeInterval
    private var timer: Timer?

    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    func scheduleRepeating(block: @escaping () async -> Void) {
        let timer = Timer(timeInterval: timeInterval, repeats: true) { _ in
            Task { await block() }
        }
        self.timer = timer
        RunLoop.current.add(timer, forMode: .common)
    }

    func fire() {
        timer?.fire()
    }

    func stop() {
        timer?.invalidate()
    }
}
