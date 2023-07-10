//
//  AppTests.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class AppTests: XCTestCase {
    private let app = App()

    func testValues() {
        XCTAssertNotNil(app.name)
        XCTAssertNotNil(app.version)
        XCTAssertNotNil(app.build)
        XCTAssertNotNil(app.language)
        XCTAssertNotNil(app.sdkVersion)
        XCTAssertEqual(app.isBackgroundEnabled, UIApplication.shared.isBackgroundEnabled)
    }
}
