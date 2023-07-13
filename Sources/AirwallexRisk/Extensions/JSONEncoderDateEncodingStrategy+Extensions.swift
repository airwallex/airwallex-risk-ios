//
//  JSONEncoderDateEncodingStrategy+Extensions.swift
//  
//
//  Created by Richie Shilton on 13/7/2023.
//

import Foundation

extension JSONEncoder.DateEncodingStrategy {
    // To be used as the `dateEncodingStrategy` when ecoding `Event`s. This converts the `TimeInterval` into an `Int64` to remove the fractional digits.
    static var wholeMillisecondsSince1970: Self {
        .custom { (date, encoder) in
            let int = Int64(date.timeIntervalSince1970 * 1000)
            var container = encoder.singleValueContainer()
            try container.encode(int)
        }
    }
}
