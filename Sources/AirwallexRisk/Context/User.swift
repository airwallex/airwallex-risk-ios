//
//  User.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 6/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

struct User {
    let id: String?

    init(id: String?) {
        self.id = id
    }
}

extension User: Storable {
    static func defaultValue() -> User {
        .init(id: nil)
    }
}
