// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "RequestReplay",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "RequestReplay", targets: ["RequestReplay"]),
        .library(name: "JSONReader", targets: ["JSONReader"]),
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "RequestReplay",
            dependencies: ["JSONReader"]
        ),
        // This `JSONReader` target is used for reading json files
        // within the `Resources` foler via `Bundle.module`.
        // For some reason, it doesn't work under the `.executableTarget` with Xcode
        // https://bugs.swift.org/browse/SR-13773
        .target(
            name: "JSONReader",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "RequestReplayTests",
            dependencies: ["RequestReplay"]
        ),
        .testTarget(
            name: "JSONReaderTests",
            dependencies: ["JSONReader"]
        ),
    ]
)
