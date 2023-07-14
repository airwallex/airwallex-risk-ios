//
//  AirwallexRisk+Header.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension AirwallexRisk {
    var header: Header? {
        .init(
            field: AirwallexKey.header,
            value: context.deviceID.uuidString
        )
    }
}
