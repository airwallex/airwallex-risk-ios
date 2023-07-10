//
//  Storage.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 6/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//
	

import Foundation

@propertyWrapper
struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T
    private let defaults: UserDefaults?

    /// Property wrapper to store Codable objects in UserDefaults.
    /// If no value is set, `defaultValue` will be stored to UserDefaults for subsequent usage.
    ///
    init(
        key: String,
        defaultValue: T,
        defaults: UserDefaults? = .sdk
    ) {
        self.key = key
        self.defaultValue = defaultValue
        self.defaults = defaults
    }

    var wrappedValue: T {
        get {
            guard let data = defaults?.object(forKey: key) as? Data,
                  let value = try? JSONDecoder().decode(T.self, from: data) else {
                return set(defaultValue)
            }
            return value
        }
        set {
            set(newValue)
        }
    }

    @discardableResult
    private func set(_ newValue: T) -> T {
        let data = try? JSONEncoder().encode(newValue)
        defaults?.set(data, forKey: key)
        return newValue
    }
}
