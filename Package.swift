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
        .executable(
            name: "NativeCNRegistry",
            targets: ["NativeCNRegistry"]
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
        .executableTarget(
            name: "NativeCNRegistry",
            path: "Tools/NativeCNRegistry"
        ),
        .testTarget(
            name: "NativeCNTests",
            dependencies: ["NativeCN"]
        ),
    ]
)
