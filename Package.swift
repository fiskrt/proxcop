// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "proxcop",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .executable(name: "proxcop", targets: ["proxcop"])
    ],
    targets: [
        .executableTarget(
            name: "proxcop"),
    ]
)
