# Airwallex Risk iOS SDK

![Bitrise](https://img.shields.io/bitrise/8dac12ec-13a2-44fe-9492-8bccbf558dd2/main?token=iibkN6UESXAQsLNb8biNqg)
![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-333333.svg)
![Swift](https://img.shields.io/badge/Swift-5.8-blue.svg)
![SPM](https://img.shields.io/badge/SPM-compatible-orange)

The Airwallex Risk SDK is required for Airwallex scale customer apps.

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

The SDK must be started as early as possible in your application lifecycle. We recommend adding the `start(accountID:with:)` method in the application delegate:

```swift
import AirwallexRisk

class AppDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Risk.start(
      accountID: "YOUR_ACCOUNT_ID", // Required
      with: AirwallexRiskConfiguration(isProduction: true)
    )
  }
}
```

**Notes**: 
- `accountID` is required in all Airwallex scale customer apps. This will be your Airwallex account ID.
- the optional `AirwallexRiskConfiguration` may also be used if needed. For test/debug builds you can set `isProduction: false` or `environment: .staging/.demo`. You can also customise the frequency of sending logs by `bufferTimeInterval: 5`.  

#### Update user

After the app user signs in to their Airwallex account, the app must send the users ID through to the SDK as follows. This will be persisted in the SDK until the next time this method is called. Set to `nil` on sign out.

:warning: **Important**: The user ID here is the signed in user's individual Airwallex account ID, not your own system user ID.

```swift
import AirwallexRisk

Risk.set(userID: "USER_ID")
```
  
#### Events

Use the following snippet to send events.

```swift
import AirwallexRisk

// Send predefined event
Risk.log(
  event: .transactionInitiated, // Risk.Events
  screen: "screen_name" // String?
)

// Send custom event
Risk.log(
  event: "event_name", // String
  screen: "screen_name" // String?
)

// Available predefined events:
// - .transactionInitiated - User starts a new transaction flow
// - .cardPinViewed - User accessed/viewed card PIN
// - .cardCvcViewed - User accessed/viewed card CVC/CVV
// - .profilePhoneUpdated - User changed their phone number
// - .profileEmailUpdated - User changed their email address
```

**Objective-C usage:**
```objc
@import AirwallexRisk;

// Send predefined event
[AWXRisk logPredefinedEvent:AWXRiskEvents.transactionInitiated screen:@"screen_name"];

// Send custom event
[AWXRisk logWithEvent:@"event_name" screen:@"screen_name"];
```

> [!NOTE]
> User login and logout events will be automatically logged when you call Risk.set(userID:) starting from version 1.2.0.

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
