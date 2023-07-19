// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AirwallexRisk",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AirwallexRisk",
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
