// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let buildForXCFramework = ProcessInfo.processInfo.environment["BUILD_FOR_XCFRAMEWORK"] == "true"
let libraryType: Product.Library.LibraryType? = buildForXCFramework ? .dynamic : nil

let package = Package(
    name: "AirwallexRisk",
    platforms: [
        .iOS(.v13), .macOS(.v13), .watchOS(.v7), .tvOS(.v14)
    ],
    products: [
        .library(
            name: "AirwallexRisk",
            type: libraryType,
            targets: ["AirwallexRisk"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AirwallexRisk",
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "AirwallexRiskTests",
            dependencies: ["AirwallexRisk"]
        ),
    ]
)
