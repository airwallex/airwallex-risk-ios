//
//  AuthService.swift
//  AirwallexRiskExample
//
//  Created by Richie Shilton on 26/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
import AirwallexRisk

// Mock auth manager for the login example.
class AuthService {
    struct User {
        let id: String
        let username: String
    }

    @discardableResult
    func login(username: String, password: String) -> User {
        // When the user logs in, set the user id and log the login event.
        let user = User(id: UUID().uuidString, username: username)
        Risk.set(userID: user.id)
        Risk.log(event: "login")
        return user
    }
}
