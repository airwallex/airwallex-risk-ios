//
//  EventTests+RiskEvents.swift
//  AirwallexRisk
//
//  Created by GitHub Copilot on behalf of user.
//

import XCTest
@testable import AirwallexRisk

final class RiskEventsRawRepresentableTests: XCTestCase {
    func testRawValuesForPredefinedEvents() {
        XCTAssertEqual(Risk.Events.transactionInitiated.rawValue, "transaction_initiated")
        XCTAssertEqual(Risk.Events.cardPinViewed.rawValue, "card_pin_viewed")
        XCTAssertEqual(Risk.Events.cardCvcViewed.rawValue, "card_cvc_viewed")
        XCTAssertEqual(Risk.Events.profilePhoneUpdated.rawValue, "profile_phone_updated")
        XCTAssertEqual(Risk.Events.profileEmailUpdated.rawValue, "profile_email_updated")
    }

    func testInitFromRawValueForPredefinedEvents() {
        XCTAssertEqual(Risk.Events(rawValue: "transaction_initiated"), .transactionInitiated)
        XCTAssertEqual(Risk.Events(rawValue: "card_pin_viewed"), .cardPinViewed)
        XCTAssertEqual(Risk.Events(rawValue: "card_cvc_viewed"), .cardCvcViewed)
        XCTAssertEqual(Risk.Events(rawValue: "profile_phone_updated"), .profilePhoneUpdated)
        XCTAssertEqual(Risk.Events(rawValue: "profile_email_updated"), .profileEmailUpdated)
    }
}
