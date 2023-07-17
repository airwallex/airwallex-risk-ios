//
//  Account.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

struct Account {
    let id: String?

    init(id: String?) {
        self.id = id
    }
}

extension Account: Storable {
    static func defaultValue() -> Account {
        .init(id: nil)
    }
}
