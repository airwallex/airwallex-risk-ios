//
//  PaymentManager.swift
//  AirwallexRiskExample
//
//  Created by Richie Shilton on 26/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
import AirwallexRisk

// Mock payment manager for the payout example.
class PaymentManager {
    func submitPaymentRequest() {
        // Attatch the risk header to any `www.airwallex.com` requests.
        // You can use the following convenience method, or directly set the header from `Airwallex.header`.
        var paymentRequest = URLRequest(url: URL(string: "https://www.airwallex.com/...")!)
        paymentRequest.setAirwallexHeader()
        
        // Log the payout event when sending payments.
        AirwallexRisk.log(event: "payout", screen: "shop")
    }
}

