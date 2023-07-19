//
//  Storable.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

protocol Storable: Codable, DefaultValueType { }

protocol DefaultValueType {
    static func defaultValue() -> Self
}

extension UUID: Storable {
    static func defaultValue() -> UUID {
        .init()
    }
}
