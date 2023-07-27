//
//  ShopView.swift
//  AirwallexRiskExample
//
//  Created by Richie Shilton on 27/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
import SwiftUI

struct ShopView: View {
    @ObservedObject var model: ContentViewModel

    var body: some View {
        VStack(spacing: 8) {
            Spacer()

            Text("Send payment")
                .bold()

            Text("Tap **send** to submit your payment.")

            Button("Send") {
                model.submitPayment()
            }
            .padding()

            Spacer()

            Button("Log out") {
                model.logout()
            }
            .padding()
        }
    }
}
