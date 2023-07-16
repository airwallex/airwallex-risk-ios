//
//  User.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 6/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: String?

    init(id: String? = nil) {
        self.id = id
    }
}
