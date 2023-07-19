//
//  Header.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

/// Airwallex header type. Can be mapped to URL request headers.
public struct Header {
    public let field: String
    public let value: String
}
