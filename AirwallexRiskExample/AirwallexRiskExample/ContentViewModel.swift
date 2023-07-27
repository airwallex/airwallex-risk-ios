//
//  ContentViewModel.swift
//  AirwallexRiskExample
//
//  Created by Richie Shilton on 26/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation

class ContentViewModel: ObservableObject {
    enum ViewState {
        case initial
        case authenticated
    }

    @Published var username: String = "test@airwallex.com"
    @Published var password: String = "Password123"
    @Published var viewState: ViewState = .initial
    private let authService = AuthService()
    private let paymentManager = PaymentManager()

    func login() {
        authService.login(username: username, password: password)
        viewState = .authenticated
    }

    func logout() {
        viewState = .initial
    }

    func submitPayment() {
        paymentManager.submitPaymentRequest()
    }
}
