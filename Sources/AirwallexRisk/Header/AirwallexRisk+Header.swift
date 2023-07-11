//
//  AirwallexRisk+Header.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension AirwallexRisk {

    /// Header to be attached to all airwallex.com requests.
    ///
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
