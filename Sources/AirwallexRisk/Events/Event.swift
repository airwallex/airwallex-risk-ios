//
//  Event.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 12/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

struct Event: Codable {
    let eventID: UUID
    let type: EventType
    let accountID: String?
    let userID: String?
    let deviceID: UUID
    let sessionID: UUID
    let tenant: Tenant
    let isApp: Bool
    let app: App
    let device: Device
    let createdAtUTC: Date
    let screen: Screen

    init(
        eventID: UUID = .init(),
        type: EventType,
        path: String?,
        context: AirwallexRiskContext,
        createdAtUTC: Date = .init()
    ) {
        self.eventID = eventID
        self.type = type
        self.accountID = context.accountID
        self.userID = context.user.userID
        self.deviceID = context.deviceID
        self.sessionID = context.sessionID
        self.tenant = context.tenant
        self.isApp = true
        self.app = .init(app: context.app)
        self.device = .init(device: context.device)
        self.createdAtUTC = createdAtUTC
        self.screen = .init(path: path)
    }

    enum CodingKeys: String, CodingKey {
        case eventID = "eventId"
        case type
        case accountID = "accountId"
        case userID = "userId"
        case deviceID = "deviceId"
        case sessionID = "sessionId"
        case tenant
        case isApp
        case app
        case device
        case createdAtUTC
        case screen
    }
}
