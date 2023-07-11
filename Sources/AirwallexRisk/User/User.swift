//
//  User.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 6/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

struct User: Codable {
    let accountID: UUID?
    let userID: UUID?

    init(
        accountID: UUID? = nil,
        userID: UUID? = nil
    ) {
        self.accountID = accountID
        self.userID = userID
    }
}
