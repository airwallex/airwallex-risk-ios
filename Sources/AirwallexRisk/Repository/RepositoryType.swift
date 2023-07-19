//
//  RepositoryType.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 18/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

protocol RepositoryType<T> {
    // swiftlint:disable:next type_name
    associatedtype T
    func add(_ item: T)
    func add(_ items: [T])
    func get() -> [T]
    func popAll() -> [T]?
}
