//
//  EventType.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 12/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

/// App lifecycle event types. Split into public app events, and events automatically logged by the SDK.
enum EventType: Equatable {
    enum SDKEvent: String, Codable {
        case installation
        case open
    }

    case automatic(event: SDKEvent)
    case custom(event: String)
}

extension EventType {
    init(stringValue: String) {
        if let event = SDKEvent(rawValue: stringValue) {
            self = .automatic(event: event)
        } else {
            self = .custom(event: stringValue)
        }
    }
}

extension EventType: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self = EventType(stringValue: value)
    }

    public func encode(to encoder: Encoder) throws {
        var value = encoder.singleValueContainer()
        switch self {
        case .custom(let event):
            try value.encode(event)
        case .automatic(let event):
            try value.encode(event)
        }
    }
}
