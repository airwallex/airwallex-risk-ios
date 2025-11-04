# Airwallex Risk iOS SDK

![Bitrise](https://img.shields.io/bitrise/8dac12ec-13a2-44fe-9492-8bccbf558dd2/main?token=iibkN6UESXAQsLNb8biNqg)
![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-333333.svg)
![Swift](https://img.shields.io/badge/Swift-5.8-blue.svg)
![SPM](https://img.shields.io/badge/SPM-compatible-orange)

The Airwallex Risk SDK provides device intelligence and fraud detection capabilities for merchant and platform apps that integrate with Airwallex services.

## Use Cases

This SDK supports two primary scenarios:

1. **Payment Acceptance (PA)**: For merchant mobile apps accepting payments
2. **Connected Accounts**: For platforms that programmatically create connected accounts for businesses and individuals, and enable them with financial capabilities

## Table of contents

<!--ts-->
  * [Requirements](#requirements)
  * [Installation](#installation)
  * [Usage](#usage)
    * [Quick start](#quick-start)
    * [Update user](#update-user) 
    * [Events](#events)
    * [Request header](#request-header)

<!--te-->

## Requirements

* iOS 13+, macOS 13+, watchOS 7+, tvOS 14+
* Swift 5.8+

### Installation

#### Swift Package Manager

- File > Add Packages…
- Enter package URL `https://github.com/airwallex/airwallex-risk-ios`
- Select "Up to Next Major Version"

These instructions may vary slightly for different Xcode versions. If you encounter any problem or have a question about adding the package to an Xcode project, we suggest reading the [adding package dependencies to your app](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app) guide from Apple.

## Usage

#### Quick start

The SDK must be started as early as possible in your application lifecycle. We recommend adding the `start(accountID:with:)` method in the application delegate.

**For Payment Acceptance (PA) scenario:**

```swift
import AirwallexRisk

class AppDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Risk.start(
      accountID: "YOUR_MERCHANT_ACCOUNT_ID", // Required: The PA merchant's account ID at Airwallex
      with: AirwallexRiskConfiguration(
        isProduction: true,
        tenant: .pa
      )
    )
  }
}
```

**For Connected Accounts scenario:**

```swift
import AirwallexRisk

class AppDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Risk.start(
      accountID: nil, // Optional: Set connected account ID later via Risk.set(accountID:)
      with: AirwallexRiskConfiguration(
        isProduction: true,
        tenant: .scale
      )
    )
  }
}
```

**Notes**:
- **Payment Acceptance**:
  - `accountID` is **required** and should be the PA merchant's account ID at Airwallex
  - `tenant` must be set to `.pa`
- **Connected Accounts**:
  - `accountID` is **optional** at startup (set it later via `Risk.set(accountID:)` once the platform user signs in and the connected account is available)
  - `tenant` must be set to `.scale`
- The optional `AirwallexRiskConfiguration` may also be used if needed. For test/debug builds you can set `isProduction: false` or `environment: .staging/.demo`. You can also customise the frequency of sending logs by `bufferTimeInterval: 5`.  

#### Update user

The SDK needs to be updated when users sign in or out.

**For Payment Acceptance (PA) scenario:**

There are two cases for setting user ID:

**Case 1: Registered user checkout (Recommended)**

When using [registered user checkout](https://www.airwallex.com/docs/payments__create-a-customer), set the user ID to the Airwallex Customer ID after creating the customer:

```swift
import AirwallexRisk

// After creating a customer at Airwallex via Create a Customer API
Risk.set(userID: "AIRWALLEX_CUSTOMER_ID") // Set to Airwallex Customer ID
Risk.set(userID: nil) // Set to nil on sign out
```

:warning: **Important**: The user ID should be the **Airwallex Customer ID** returned from the [Create a Customer API](https://www.airwallex.com/docs/payments__create-a-customer).

**Case 2: Guest checkout**

For guest checkout flows where users don't register, you can skip setting the user ID:

```swift
// No need to call Risk.set(userID:) for guest checkout
```

**For Connected Accounts scenario:**

**Required:** When a platform user (connected account) signs in or out, set only the account ID:

```swift
import AirwallexRisk

// On platform user sign in
let connectedAccountId = "CONNECTED_ACCOUNT_ID" // The connected account's Airwallex account ID from Create a connected account API
Risk.set(accountID: connectedAccountId)

// On platform user sign out
Risk.set(accountID: nil)
```

:warning: **Important**: For Connected Accounts, do **NOT** set `userID`. Only set `accountID` to the connected account's Airwallex account ID (not the platform's account ID). The account ID is the `id` returned from the [Create a connected account API](https://www.airwallex.com/docs/api#/Scale/Accounts/_api_v1_accounts_create/post).
  
#### Events

Some app events must be logged to the SDK. These events include:
- _User logs in:_ When a user logs in, send the event "login". Make sure you **set the user ID** (above) before sending this event.
- _Create a payout transaction:_ When a user submits a payment transaction, send the event "payout".

Use the following snippet to send event name and current screen name.

```swift
import AirwallexRisk

Risk.log(
  event: "EVENT_NAME",
  screen: "SCREEN_NAME"
)
```

#### Request header

When your app sends a request to Airwallex, you must add the provided header into your request before sending. An example implementation follows:

```swift
import AirwallexRisk

guard let header = Risk.header else {
  return
}
var request = URLRequest(url: URL(string: "https://www.airwallex.com/...")!)
request.setValue(header.value, forHTTPHeaderField: header.field)
```

Alternatively, the SDK provides a convenience URLRequest extension method that can be used to directly add the header to any Airwallex request:

```swift
import AirwallexRisk

var request = URLRequest(url: URL(string: "https://www.airwallex.com/...")!)
request.setAirwallexHeader()
```

The header consists of
- the field, which will always be `"x-risk-device-id"`, and
- the value, which will be an internally generated device identifier.

#### Session ID

You can get the unique ID per app running session and provide it into Airwallex requests if needed (optional).

```swift
import AirwallexRisk

let sessionID = Risk.SessionID
```
