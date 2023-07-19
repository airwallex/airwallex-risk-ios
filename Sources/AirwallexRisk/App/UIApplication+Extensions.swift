//
//  UIApplication+Extensions.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    var isBackgroundEnabled: Bool {
        UIApplication.shared.backgroundRefreshStatus == .available
    }
}
