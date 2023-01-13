// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VRUIKit",
	platforms: [
		.iOS(.v15),
	],
    products: [
        .library(
            name: "VRUIKit",
            targets: ["VRUIKit"]
		),
    ],
    dependencies: [
		.package(
			url: "https://github.com/pointfreeco/swift-snapshot-testing",
			exact: "1.10.0"
		),
    ],
    targets: [
        .target(
            name: "VRUIKit",
            dependencies: []
		),
        .testTarget(
            name: "VRUIKitTests",
            dependencies: [
				"VRUIKit",
				.product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
			]
		),
    ]
)
