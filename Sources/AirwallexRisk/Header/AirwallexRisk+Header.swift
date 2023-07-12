//
//  AirwallexRisk+Header.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension AirwallexRisk {
    /// Airwallex risk request header.
    ///
    /// This header should be attached to each request made to `www.airwallex.com`.
    /// - Note: You can directly attach this header to a request with the `URLRequest` extension method `setAirwallexHeader()`.
    public static var header: Header? {
        guard let context = shared.context else {
            print(AirwallexValue.notStartedWarning)
            return nil
        }
        return .init(
            field: AirwallexKey.header,
            value: context.device.id.uuidString
        )
    }
}
