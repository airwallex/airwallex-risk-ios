//
//  HTTPErrors.swift
//  AirwallexRisk
// 
//  Created by Richie Shilton on 7/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//
	
import Foundation

enum HTTPRequestError: Error {
    case invalidURL
}

enum HTTPResponseError: Error {
    case invalid(statusCode: Int?)
}
