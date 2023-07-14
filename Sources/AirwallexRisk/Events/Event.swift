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
    let deviceID: UUID
    let sessionID: UUID
    let tenant: Tenant
    let accountID: String?
    let userID: String?
    let app: App
    let device: Device
    let createdAtUTC: Date
    let type: EventType
    let screen: Screen

    init(
        eventID: UUID = .init(),
        createdAtUTC: Date = .init(),
        type: EventType,
        path: String?,
        context: AirwallexRiskContext
    ) {
        self.eventID = eventID
        self.deviceID = context.deviceID
        self.sessionID = context.sessionID
        self.tenant = context.tenant
        self.accountID = context.accountID
        self.userID = context.user.userID
        self.app = .init(app: context.dataCollector.app)
        self.device = .init(device: context.dataCollector.device)
        self.createdAtUTC = createdAtUTC
        self.type = type
        self.screen = .init(path: path)
    }

    enum CodingKeys: String, CodingKey {
        case eventID = "eventId"
        case deviceID = "deviceId"
        case sessionID = "sessionId"
        case tenant
        case accountID = "accountId"
        case userID = "userId"
        case app
        case device
        case createdAtUTC
        case type
        case screen
    }
}
