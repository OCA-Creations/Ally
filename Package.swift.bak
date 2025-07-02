// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Ally",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.2.3")),
        .package(url: "https://github.com/realm/SwiftLint.git", .upToNextMajor(from: "0.54.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Ally",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
        .testTarget(name: "Ally.macOSTests")
        
    ]
)
