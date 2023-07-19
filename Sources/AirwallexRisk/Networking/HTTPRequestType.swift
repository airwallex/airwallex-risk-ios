//
//  HTTPRequestType.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

protocol HTTPRequestType {
    var host: String { get }
    var path: String { get }
    var method: HTTPRequestMethod { get }
}
