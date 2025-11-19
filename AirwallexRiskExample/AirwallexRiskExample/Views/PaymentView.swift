//
//  PaymentView.swift
//  AirwallexRiskExample
//
//  Created by Richie Shilton on 27/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
import SwiftUI

struct PaymentView: View {
    @ObservedObject var model: ContentViewModel

    var body: some View {
        VStack(spacing: 8) {
            Spacer()

            // Predefined Events
            Text("Predefined Events")
                .bold()
            
            Button("Transaction Initiated", action: model.logTransactionInitiated)
                .buttonStyle(.bordered)
            
            Button("Card PIN Viewed") {
                model.logCardPinViewed()
            }
            .buttonStyle(.bordered)

            Button("Card CVC Viewed") {
                model.logCardCvcViewed()
            }
            .buttonStyle(.bordered)

            Button("Profile Phone Updated") {
                model.logProfilePhoneUpdated()
            }
            .buttonStyle(.bordered)

            Button("Profile Email Updated") {
                model.logProfileEmailUpdated()
            }
            .buttonStyle(.bordered)
            .padding(.bottom, 20)

            // Predefined Events
            Text("Custom Event")
                .bold()

            Button("Trigger Custom Event") {
                model.submitPayment()
            }
            .buttonStyle(.bordered)
            Spacer()

            Button("Log out") {
                model.logout()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}


#Preview {
    PaymentView(model: ContentViewModel())
}
