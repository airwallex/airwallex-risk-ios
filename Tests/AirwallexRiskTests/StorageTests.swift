//
//  StorageTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 6/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//
	
import XCTest
@testable import AirwallexRisk

final class StorageTests: XCTestCase {
    private static let key = "storage-test"
    private static let defaults = UserDefaults(suiteName: UUID().uuidString)

    @Storage(key: StorageTests.key, defaultValue: .init(id: nil), defaults: StorageTests.defaults)
    private var test: CodableMock

    func testStorage() {
        let id = "Identifier"
        XCTAssertNil(test.id)

        test = .init(id: id)
        XCTAssertEqual(test.id, id)
        let data = StorageTests.defaults?.object(forKey: Self.key) as! Data
        let first = try! JSONDecoder().decode(CodableMock.self, from: data)
        XCTAssertEqual(test.id, first.id)

        test = .init(id: nil)
        XCTAssertNil(test.id)
        let data2 = StorageTests.defaults?.object(forKey: Self.key) as! Data
        let second = try! JSONDecoder().decode(CodableMock.self, from: data2)
        XCTAssertNil(second.id)
    }
}
