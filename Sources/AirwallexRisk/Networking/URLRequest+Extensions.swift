//
//  URLRequest+Extensions.swift.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension URLRequest {
    init(request: HTTPRequestType) throws {
        let url = try URL(request: request)

        self.init(url: url)

        httpMethod = String(describing: request.method)

        if case .post(let body) = request.method {
            httpBody = body.jsonData
        }

        setValue(AirwallexValue.contentJSON, forHTTPHeaderField: AirwallexKey.accept)
        setValue(AirwallexValue.contentJSON, forHTTPHeaderField: AirwallexKey.contentType)
    }
}
