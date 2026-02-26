//
//  AirwallexRiskTests.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class AirwallexRiskTests: XCTestCase {
    private var repository: EventRepository!
    private var testContext: AirwallexRiskContext!
    private var testEventManager: MockEventManager!
    private var airwallexRisk: Risk!

    override func setUp() {
        repository = .init()
        testContext = .test()
        testEventManager = .init()
        airwallexRisk = Risk(
            context: testContext,
            eventManager: testEventManager
        )
    }

    func testHeader() {
        XCTAssertEqual(airwallexRisk.header.field, AirwallexKey.header)
        XCTAssertEqual(airwallexRisk.header.value, testContext.deviceID.wrappedValue.uuidString)
    }
    
    func testSessionID() {
        XCTAssertEqual(airwallexRisk.sessionID, testContext.sessionID)
    }

    func testSetAccountID() {
        let id = "accountID2"
        XCTAssertEqual(testContext.account.wrappedValue.id, "accountID")
        airwallexRisk.set(accountID: id)
        XCTAssertEqual(testContext.account.wrappedValue.id, "accountID2")
        XCTAssertEqual(testContext.account.wrappedValue.id, id)
        airwallexRisk.set(accountID: nil)
        XCTAssertNil(testContext.account.wrappedValue.id)
    }

    // MARK: - Account Login/Logout Event Tests by Tenant

    func testSetAccountIDQueuesLoginEventForScaleTenant() {
        // Clear stored accountID and userID before each test
        UserDefaults.sdk?.removeObject(forKey: AirwallexUserDefaultKey.account)
        UserDefaults.sdk?.removeObject(forKey: AirwallexUserDefaultKey.user)

        // Start with no account (nil)
        let scaleContext = AirwallexRiskContext.test(accountID: nil, tenant: .scale)
        let eventManager = MockEventManager()
        let risk = Risk(context: scaleContext, eventManager: eventManager)

        XCTAssertEqual(eventManager.events.count, 0)
        risk.set(accountID: "newAccountID")
        // Only login event (no logout since existing was nil)
        XCTAssertEqual(eventManager.events.count, 1)
        XCTAssertEqual(eventManager.events[0].event.type, .automatic(event: .accountLogin))
    }

    func testSetAccountIDQueuesLogoutThenLoginWhenSwitchingAccounts() {
        // Start with existing account
        let scaleContext = AirwallexRiskContext.test(accountID: "initial", tenant: .scale)
        let eventManager = MockEventManager()
        let risk = Risk(context: scaleContext, eventManager: eventManager)

        XCTAssertEqual(eventManager.events.count, 0)
        risk.set(accountID: "newAccountID")
        // Logout for old account + login for new account
        XCTAssertEqual(eventManager.events.count, 2)
        XCTAssertEqual(eventManager.events[0].event.type, .automatic(event: .accountLogout))
        XCTAssertEqual(eventManager.events[1].event.type, .automatic(event: .accountLogin))
    }

    func testSetAccountIDDoesNothingWhenSameValue() {
        let scaleContext = AirwallexRiskContext.test(accountID: "same", tenant: .scale)
        let eventManager = MockEventManager()
        let risk = Risk(context: scaleContext, eventManager: eventManager)

        XCTAssertEqual(eventManager.events.count, 0)
        risk.set(accountID: "same")
        // No events when value is unchanged
        XCTAssertEqual(eventManager.events.count, 0)
    }

    func testSetAccountIDNilQueuesAccountLogoutEventForScaleTenant() {
        let scaleContext = AirwallexRiskContext.test(accountID: "initial", tenant: .scale)
        let eventManager = MockEventManager()
        let risk = Risk(context: scaleContext, eventManager: eventManager)

        XCTAssertEqual(eventManager.events.count, 0)
        risk.set(accountID: nil)
        XCTAssertEqual(eventManager.events.count, 1)
        XCTAssertEqual(eventManager.events.first?.event.type, .automatic(event: .accountLogout))
    }

    func testSetAccountIDDoesNotQueueEventForInternalTenant() {
        let internalContext = AirwallexRiskContext.test(accountID: "initial", tenant: .internal)
        let eventManager = MockEventManager()
        let risk = Risk(context: internalContext, eventManager: eventManager)

        XCTAssertEqual(eventManager.events.count, 0)
        risk.set(accountID: "newAccountID")
        XCTAssertEqual(eventManager.events.count, 0)
        risk.set(accountID: nil)
        XCTAssertEqual(eventManager.events.count, 0)
    }

    func testSetAccountIDDoesNotQueueEventForPATenant() {
        let paContext = AirwallexRiskContext.test(accountID: "initial", tenant: .pa)
        let eventManager = MockEventManager()
        let risk = Risk(context: paContext, eventManager: eventManager)

        XCTAssertEqual(eventManager.events.count, 0)
        risk.set(accountID: "newAccountID")
        XCTAssertEqual(eventManager.events.count, 0)
        risk.set(accountID: nil)
        XCTAssertEqual(eventManager.events.count, 0)
    }

    func testSetAccountIDLoginLogoutSequenceForScaleTenant() {
        // Clear stored accountID and userID before each test
        UserDefaults.sdk?.removeObject(forKey: AirwallexUserDefaultKey.account)
        UserDefaults.sdk?.removeObject(forKey: AirwallexUserDefaultKey.user)

        // Start with no account
        let scaleContext = AirwallexRiskContext.test(accountID: nil, tenant: .scale)
        let eventManager = MockEventManager()
        let risk = Risk(context: scaleContext, eventManager: eventManager)

        // Login (nil -> account1: login only, no logout since existing was nil)
        risk.set(accountID: "account1")
        XCTAssertEqual(eventManager.events.count, 1)
        XCTAssertEqual(eventManager.events[0].event.type, .automatic(event: .accountLogin))

        // Logout (account1 -> nil: logout only)
        risk.set(accountID: nil)
        XCTAssertEqual(eventManager.events.count, 2)
        XCTAssertEqual(eventManager.events[1].event.type, .automatic(event: .accountLogout))

        // Login again (nil -> account2: login only, no logout since existing was nil)
        risk.set(accountID: "account2")
        XCTAssertEqual(eventManager.events.count, 3)
        XCTAssertEqual(eventManager.events[2].event.type, .automatic(event: .accountLogin))

        // Switch accounts (account2 -> account3: logout + login)
        risk.set(accountID: "account3")
        XCTAssertEqual(eventManager.events.count, 5)
        XCTAssertEqual(eventManager.events[3].event.type, .automatic(event: .accountLogout))
        XCTAssertEqual(eventManager.events[4].event.type, .automatic(event: .accountLogin))

        // Same account (account3 -> account3: no events)
        risk.set(accountID: "account3")
        XCTAssertEqual(eventManager.events.count, 5)
    }

    func testSetUserID() {
        let id = "userID"
        XCTAssertNil(testContext.user.wrappedValue.id)
        airwallexRisk.set(userID: id)
        // Login only (no logout since existing was nil)
        XCTAssertEqual(testEventManager.events.count, 1)
        XCTAssertEqual(testEventManager.events[0].event.type, .automatic(event: .userLogin))
        XCTAssertEqual(testContext.user.wrappedValue.id, id)
        airwallexRisk.set(userID: nil)
        XCTAssertNil(testContext.user.wrappedValue.id)
        // Logout event only
        XCTAssertEqual(testEventManager.events.count, 2)
        XCTAssertEqual(testEventManager.events[1].event.type, .automatic(event: .userLogout))
    }

    func testSetUserIDQueuesLogoutThenLoginWhenSwitchingUsers() {
        XCTAssertNil(testContext.user.wrappedValue.id)
        // First login (nil -> user1: login only, no logout since existing was nil)
        airwallexRisk.set(userID: "user1")
        XCTAssertEqual(testEventManager.events.count, 1)
        XCTAssertEqual(testEventManager.events[0].event.type, .automatic(event: .userLogin))

        // Switch users (user1 -> user2: logout + login)
        airwallexRisk.set(userID: "user2")
        XCTAssertEqual(testEventManager.events.count, 3)
        XCTAssertEqual(testEventManager.events[1].event.type, .automatic(event: .userLogout))
        XCTAssertEqual(testEventManager.events[2].event.type, .automatic(event: .userLogin))

        // Same user (user2 -> user2: no events)
        airwallexRisk.set(userID: "user2")
        XCTAssertEqual(testEventManager.events.count, 3)
    }

    func testLogEvent() {
        XCTAssertEqual(testEventManager.events.count, .zero)
        airwallexRisk.log(event: "login")
        XCTAssertEqual(testEventManager.events.count, 1)
    }
    
    func testLogPredefinedEvent() {
        XCTAssertEqual(testEventManager.events.count, .zero)
        let events: [Risk.Events] = [
            .transactionInitiated,
            .cardCvcViewed,
            .cardPinViewed,
            .profileEmailUpdated,
            .profilePhoneUpdated
        ]
        
        for (index, event) in events.enumerated() {
            XCTAssertEqual(testEventManager.events.count, index)
            airwallexRisk.log(event: event)
        }
        XCTAssertEqual(testEventManager.events.count, events.count)
    }
}
