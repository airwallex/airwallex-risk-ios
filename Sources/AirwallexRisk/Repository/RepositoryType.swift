//
//  RepositoryType.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 18/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

protocol RepositoryType<T> {
    associatedtype T
    func add(_ event: T)
    func add(_ events: [T])
    func get() -> [T]
    func popAll() -> [T]?
}
