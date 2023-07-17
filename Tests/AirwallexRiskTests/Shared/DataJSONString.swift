//
//  File.swift
//  
//
//  Created by Richie Shilton on 14/7/2023.
//

import Foundation

extension Data {
    enum JSONString: Error {
        case serialisation
    }

    // Helper to test json encoding.
    var jsonString: String {
        get throws {
            guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
                  let data = try? JSONSerialization.data(withJSONObject: object, options: [.sortedKeys]),
                  let jsonString = String(data: data, encoding: .utf8) else {
                throw JSONString.serialisation
            }

            return jsonString
        }
    }
}
