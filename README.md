# Airwallex Risk iOS SDK

![Bitrise](https://img.shields.io/bitrise/8dac12ec-13a2-44fe-9492-8bccbf558dd2/master?token=iibkN6UESXAQsLNb8biNqg)
![Platforms](https://img.shields.io/badge/platforms-iOS-333333.svg)
![SPM](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange)

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

The Airwallex Risk iOS SDK requires Xcode 14.1 or later and is compatible with apps targeting iOS 13 or above.

### Installation

#### Swift Package Manager

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/airwallex/airwallex-risk-ios.git`
- Select "Up to Next Major"

If you encounter any problem or have a question about adding the package to an Xcode project, I suggest reading the [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app) guide from Apple.

## Usage

#### Quick start

The SDK must be started as early as possible in your application lifecycle. We recommend adding the `start(accountID:with:)` method in the application delegate:

```swift
import AirwallexRisk

class AppDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    AirwallexRisk.start(
      accountID: "YOUR_ACCOUNT_ID", // Required
      with: AirwallexRiskConfiguration(isProduction: true)
    )
  }
}
```

Notes:

- `accountID` is required in all Airwallex scale customer apps.
- the optional `AirwallexRiskConfiguration` may also be used if needed. For test/debug builds you can set `isProduction: false`.

#### Update user

After the app user signs in to their Airwallex account, the app must send the users ID through to the SDK as follows. This will be persisted in the SDK until the next time this method is called. Set to `nil` on sign out.

```swift
import AirwallexRisk

AirwallexRisk.set(userID: "USER_ID")
```
  
#### Events

Some app events must be logged to the SDK. These events include:
- _User logs in:_ When a user logs in, send the event "login". Make sure you **set the user ID** (above) before sending this event.
- _Create a payout transaction:_ When a user submits a payment transaction, send the event "payout".

Use the following snippet to send event name and current screen name.

```swift
import AirwallexRisk

AirwallexRisk.log(
  event: "EVENT_NAME",
  screen: "SCREEN_NAME"
)
```

#### Request header

When your app sends a request to Airwallex, you must add the provided header into your request before sending. An example implementation follows:

```swift
import AirwallexRisk

guard let header = AirwallexRisk.header else {
  return
}
var request = URLRequest(url: URL(string: "https://www.airwallex.com/...")!)
request.setValue(header.value, forHTTPHeaderField: header.field)
```

The SDK also provides a convenience method to directly add the header to any URLRequest:

```swift
import AirwallexRisk

var request = URLRequest(url: URL(string: "https://www.airwallex.com/...")!)
request.setAirwallexHeader()
```

