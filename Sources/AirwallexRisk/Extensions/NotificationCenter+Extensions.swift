//
//  NotificationCenter+Extensions.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
import UIKit

extension NotificationCenter {
    func onForeground(block: @escaping (Notification) -> Void) {
        addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: nil,
            using: block
        )
    }
}
