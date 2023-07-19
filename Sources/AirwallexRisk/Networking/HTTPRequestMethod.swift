//
//  HTTPRequestMethod.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

enum HTTPRequestMethod: CustomStringConvertible {
    case get
    case post(body: Encodable)

    var description: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}
