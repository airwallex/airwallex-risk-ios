//
//  EntryView.swift
//  AirwallexRiskExample
//
//  Created by Richie Shilton on 27/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import Foundation
import SwiftUI

struct EntryView: View {
    @ObservedObject var model: ContentViewModel

    var body: some View {
        VStack(spacing: 8) {
            Text("Welcome")
                .bold()

            TextField("Username", text: $model.username)
                .padding(8)
                .border(Color.gray)
                .disabled(true)

            SecureField("Password", text: $model.password)
                .padding(8)
                .border(Color.gray)
                .disabled(true)

            Button("Log in") {
                model.login()
            }
            .padding()
        }
    }
}
