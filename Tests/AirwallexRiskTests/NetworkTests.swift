//
//  NetworkTests.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import XCTest
@testable import AirwallexRisk

final class NetworkTests: XCTestCase {
    private let body = CodableMock(id: "id")

    override func setUp() {
        super.setUp()
        AirwallexRisk.start()
    }

    func testMapGetURLRequest() throws {
        let mockRequest = MockHTTPRequest()
        let urlRequest = try URLRequest(request: mockRequest)

        XCTAssertEqual(urlRequest.url, URL(string: "https://www.airwallex.com/path"))
        XCTAssertNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Accept"], "application/json")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Content-Type"], "application/json")
    }

    func testMapPostURLRequest() throws {
        let mockRequest = MockHTTPRequest(method: .post(body: body))
        let urlRequest = try URLRequest(request: mockRequest)

        XCTAssertEqual(urlRequest.url, URL(string: "https://www.airwallex.com/path"))
        XCTAssertEqual(urlRequest.httpBody, body.jsonData)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Accept"], "application/json")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Content-Type"], "application/json")
    }

    func testInvalidURLMap() {
        let mockRequest = MockHTTPRequest(path: "x")
        do {
            let _ = try URLRequest(request: mockRequest)
            XCTFail("Should throw an error: `HTTPRequestError.invalidURL`")
        } catch let error {
            XCTAssertEqual(error as? HTTPRequestError, HTTPRequestError.invalidURL)
        }
    }

    func testExecuteSuccess() async throws {
        let id = "Success"
        let session = URLSession.successMock(encodable: CodableMock(id: id))
        let mockRequest = MockHTTPRequest()
        let response: CodableMock = try await session.execute(request: mockRequest)
        XCTAssertEqual(response.id, id)
    }

    func testExecuteFailure() async throws {
        let session = URLSession.errorMock(errorCode: 500)
        let mockRequest = MockHTTPRequest()
        do {
            let _: CodableMock = try await session.execute(request: mockRequest)
        } catch let error as HTTPResponseError {
            guard case .invalid(let statusCode) = error else {
                XCTFail("Incorrect error type")
                return
            }
            XCTAssertEqual(statusCode, 500)
        }
    }
}

private struct MockHTTPRequest: HTTPRequestType {
    let path: String
    let method: HTTPRequestMethod

    init(
        path: String = "/path",
        method: HTTPRequestMethod = .get
    ) {
        self.path = path
        self.method = method
    }
}

private extension URLSession {
    static func successMock<T: Encodable>(encodable: T) -> URLSession {
        let url = URL(string: "https://www.airwallex.com/path")!
        let data = try! JSONEncoder().encode(encodable)
        let response: Response = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        URLProtocolMock.testURLs = [url: response]
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }

    static func errorMock(errorCode: Int) -> URLSession {
        let url = URL(string: "https://www.airwallex.com/path")!
        let response: Response = (nil, HTTPURLResponse(url: url, statusCode: errorCode, httpVersion: nil, headerFields: nil), nil)
        URLProtocolMock.testURLs = [url: response]
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }
}
