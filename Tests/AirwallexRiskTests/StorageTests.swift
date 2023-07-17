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
    private static let defaults: UserDefaults? = .test

    private var test: Storage<StorableMock>!

    override func setUp() {
        test = .init(
            key: StorageTests.key,
            defaults: StorageTests.defaults
        )
    }

    func testStorage() {
        let id = "Identifier"
        XCTAssertNil(test.wrappedValue.id)

        test.wrappedValue = .init(id: id)
        XCTAssertEqual(test.wrappedValue.id, id)
        let data = StorageTests.defaults?.object(forKey: Self.key) as! Data
        let first = try! JSONDecoder().decode(CodableMock.self, from: data)
        XCTAssertEqual(test.wrappedValue.id, first.id)

        test.wrappedValue = .init(id: nil)
        XCTAssertNil(test.wrappedValue.id)
        let data2 = StorageTests.defaults?.object(forKey: Self.key) as! Data
        let second = try! JSONDecoder().decode(CodableMock.self, from: data2)
        XCTAssertNil(second.id)
    }
}

// MOVE
private struct StorableMock: Storable {
    let id: String?

    static func defaultValue() -> StorableMock {
        .init(id: nil)
    }
}
