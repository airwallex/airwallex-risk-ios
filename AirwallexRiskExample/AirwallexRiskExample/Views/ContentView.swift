//
//  ContentView.swift
//  AirwallexRiskExample
//
//  Created by Richie Shilton on 26/7/2023.
//  Copyright © 2023 Airwallex. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = ContentViewModel()

    var body: some View {
        contentView
            .padding()
    }

    @ViewBuilder
    private var contentView: some View {
        switch model.viewState {
        case .initial: EntryView(model: model)
        case .authenticated: ShopView(model: model)
        }
    }
}
