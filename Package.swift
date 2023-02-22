// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Caching",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Caching", targets: ["Caching"]),
        .library(name: "Caching-Interface", targets: ["Caching-Interface"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Caching",
            dependencies: [
                "Caching-Interface"
            ]
        ),
        .testTarget(
            name: "CachingTests",
            dependencies: [
                "Caching"
            ]
        ),
        .target(
            name: "Caching-Interface",
            dependencies: []
        )
    ]
)
