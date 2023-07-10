//
//  Encodable+Extensions.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension Encodable {
    var jsonData: Data? {
        try? JSONEncoder().encode(self)
    }
}
