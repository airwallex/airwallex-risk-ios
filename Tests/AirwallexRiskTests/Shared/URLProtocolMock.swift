//
//  URLProtocolMock.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

typealias Response = (Data?, URLResponse?, Error?)

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Response]()

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url {
            if let data = URLProtocolMock.testURLs[url]?.0 {
                self.client?.urlProtocol(self, didLoad: data)
            }

            if let response = URLProtocolMock.testURLs[url]?.1 {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .allowed)
            }

            if let error = URLProtocolMock.testURLs[url]?.2 {
                self.client?.urlProtocol(self, didFailWithError: error)
            }
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
