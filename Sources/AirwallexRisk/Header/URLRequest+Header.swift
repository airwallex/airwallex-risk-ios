//
//  URLRequest+Header.swift
//  AirwallexRisk
//
//  Created by Richie Shilton on 5/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension URLRequest {
    /// Convenience extension to attach the Airwallex risk header to an Airallex URLRequest
    public mutating func setAirwallexHeader() {
        guard let header = AirwallexRisk.header else {
            return
        }
        setValue(header.value, forHTTPHeaderField: header.key)
    }
}
