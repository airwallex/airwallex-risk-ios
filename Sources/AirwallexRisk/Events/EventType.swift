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
    case app(event: AppEventType)
    case automatic(event: AutomaticEventType)
    case unknown
}

extension EventType {
    init(stringValue: String) {
        if let event = AppEventType(rawValue: stringValue) {
            self = .app(event: event)
        } else if let event = AutomaticEventType(rawValue: stringValue) {
            self = .automatic(event: event)
        } else {
            self = .unknown
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
        case .app(let event):
            try value.encode(event)
        case .automatic(let event):
            try value.encode(event)
        case .unknown:
            try value.encode(AirwallexValue.unknown)
        }
    }
}
