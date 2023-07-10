//
//  File.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

extension URLSession {
    func execute<T: Decodable>(request: HTTPRequestType) async throws -> T {
        let request = try URLRequest(request: request)
        return try await execute(request: request)
    }

    private func execute<T: Decodable>(request: URLRequest) async throws -> T {
        let (data, response) = try await data(for: request)
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        switch statusCode {
        case .some(200...299): break
        // case .some(400...499): // TODO: check if specific data/error object will be provided
        default: throw HTTPResponseError.invalid(statusCode: statusCode)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
