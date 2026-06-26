// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "NativeCN",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "NativeCN",
            targets: ["NativeCN"]
        ),
        .executable(
            name: "NativeCNCatalog",
            targets: ["NativeCNCatalog"]
        ),
    ],
    targets: [
        .target(
            name: "NativeCN"
        ),
        .executableTarget(
            name: "NativeCNCatalog",
            dependencies: ["NativeCN"],
            path: "Examples/NativeCNCatalog/NativeCNCatalog"
        ),
        .testTarget(
            name: "NativeCNTests",
            dependencies: ["NativeCN"]
        ),
    ]
)
