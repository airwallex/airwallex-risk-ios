//
//  URLSession+Mock.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 17/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension URLSession {
    static func successMock<T: Encodable>(url: URL, encodable: T) -> URLSession {
        let data = try! JSONEncoder().encode(encodable)
        let response: Response = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        URLProtocolMock.testURLs = [url: response]
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }

    static func errorMock(url: URL, errorCode: Int) -> URLSession {
        let response: Response = (nil, HTTPURLResponse(url: url, statusCode: errorCode, httpVersion: nil, headerFields: nil), nil)
        URLProtocolMock.testURLs = [url: response]
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }
}
