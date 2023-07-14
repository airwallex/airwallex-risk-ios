//
//  User.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 6/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

struct User: Codable {
    let userID: String?

    init(
        userID: String? = nil
    ) {
        self.userID = userID
    }
}
