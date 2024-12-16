// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CurveExperiments",
    platforms: [
        .macOS(.v15)
    ],
    dependencies: [
        .package(url: "https://github.com/christophhagen/Curve25519.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "4.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "CurveExperiments",
            dependencies: [
                .product(name: "Curve25519", package: "Curve25519"),
                .product(name: "Crypto", package: "swift-crypto"),
            ]
        ),
    ]
)
