# Airwallex Risk iOS SDK

![Bitrise](https://img.shields.io/bitrise/8dac12ec-13a2-44fe-9492-8bccbf558dd2/main?token=iibkN6UESXAQsLNb8biNqg)
![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-333333.svg)
![Swift](https://img.shields.io/badge/Swift-5.8-blue.svg)
![SPM](https://img.shields.io/badge/SPM-compatible-orange)

The Airwallex Risk SDK provides device intelligence and fraud detection for Airwallex customer apps.

## Use Cases

This SDK supports two primary scenarios:

1. **Payment Acceptance (PA)**: For merchant mobile apps accepting payments
2. **Scaled Platform Account**: For platforms onboarding connected accounts and facilitating transfers

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
      accountID: "YOUR_MERCHANT_ACCOUNT_ID", // Required: Your merchant's Airwallex account ID
      with: AirwallexRiskConfiguration(isProduction: true)
    )
  }
}
```

**For Scaled Platform Account scenario:**

```swift
import AirwallexRisk

class AppDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Risk.start(
      accountID: nil, // Optional: Set connected account ID later via Risk.set(accountID:)
      with: AirwallexRiskConfiguration(isProduction: true)
    )
  }
}
```

**Notes**:
- **Payment Acceptance**: `accountID` is **required** and should be your merchant's Airwallex account ID.
- **Scaled Platform**: `accountID` is **optional** at startup. Set the connected account's Airwallex account ID later using `Risk.set(accountID:)` when available.
- The optional `AirwallexRiskConfiguration` may also be used if needed. For test/debug builds you can set `isProduction: false` or `environment: .staging/.demo`. You can also customise the frequency of sending logs by `bufferTimeInterval: 5`.  

#### Update user

The SDK needs to be updated when users sign in or out.

**For Payment Acceptance (PA) scenario:**

After a user signs in, set their user ID:

```swift
import AirwallexRisk

Risk.set(userID: "USER_ID") // Set on sign in
Risk.set(userID: nil) // Set to nil on sign out
```

:warning: **Important**: The user ID should be the signed-in user's Airwallex user ID, not your own system user ID.

**For Scaled Platform Account scenario:**

When a platform user (connected account) signs in or out, set both the account ID and user ID to the connected account's Airwallex account ID:

```swift
import AirwallexRisk

// On platform user sign in
let connectedAccountId = "CONNECTED_ACCOUNT_ID" // The user's Airwallex connected account ID
Risk.set(accountID: connectedAccountId)
Risk.set(userID: connectedAccountId)

// On platform user sign out
Risk.set(accountID: nil)
Risk.set(userID: nil)
```

:warning: **Important**: For Scaled Platform, both `accountID` and `userID` should be set to the connected account's Airwallex account ID (not the platform's account ID, and not the platform's internal user ID).
  
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
