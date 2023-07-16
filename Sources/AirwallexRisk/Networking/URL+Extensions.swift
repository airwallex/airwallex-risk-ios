//
//  URL+Extensions.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 10/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension URL {
    init(request: HTTPRequestType) throws {
        var components = URLComponents()
        components.scheme = AirwallexValue.scheme
        components.host = request.host
        components.path += request.path
        guard let url = components.url else {
            throw HTTPRequestError.invalidURL
        }
        self = url
    }
}
