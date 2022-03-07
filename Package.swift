// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GEAudioPlayer",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "GEAudioPlayer",
            targets: ["GEAudioPlayer"]),
    ],
    targets: [
        .target(
            name: "GEAudioPlayer",
            dependencies: []),
        .testTarget(
            name: "GEAudioPlayerTests",
            dependencies: ["GEAudioPlayer"]),
    ]
)
