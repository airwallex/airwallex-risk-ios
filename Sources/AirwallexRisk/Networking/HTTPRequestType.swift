//
//  HTTPRequestType.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

protocol HTTPRequestType {
    var path: String { get }
    var method: HTTPRequestMethod { get }
}

extension HTTPRequestType {
    var host: String {
        get throws {
            guard let context = AirwallexRisk.shared.context else {
                print(AirwallexValue.notStartedWarning)
                throw HTTPRequestError.invalidURL
            }
            return context.environment.host
        }
    }
}
