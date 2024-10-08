// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArticleUI",
    defaultLocalization: LanguageTag(rawValue: "en"),
    platforms: [.iOS(.v18),.macOS(.v15), .visionOS(.v2), .watchOS(.v11), .tvOS(.v18)],
    products: [
        .library(
            name: "ArticleUI",
            targets: ["ArticleUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.4.0"),
    ],
    targets: [
        .target(
            name: "ArticleUI"
        ),
        .testTarget(
            name: "ArticleUITests",
            dependencies: ["ArticleUI"]
        ),
    ]
)
