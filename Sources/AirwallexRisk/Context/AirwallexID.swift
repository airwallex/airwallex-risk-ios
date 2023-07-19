//
//  AirwallexID.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 6/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

struct AirwallexID {
    let id: String?

    init(id: String?) {
        self.id = id
    }
}

extension AirwallexID: Storable {
    static func defaultValue() -> AirwallexID {
        .init(id: nil)
    }
}
