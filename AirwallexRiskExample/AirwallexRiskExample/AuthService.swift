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
        // update userId will trigger user_login event automatically
        Risk.set(userID: user.id)
        return user
    }
    
    func logout() {
        // update userId to nil will trigger user_logout event automatically
        Risk.set(userID: nil)
    }
}
