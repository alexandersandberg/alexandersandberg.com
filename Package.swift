// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "alexandersandberg.com",
	platforms: [
		.macOS(.v14)
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-crypto.git", from: "3.3.0"),
		.package(url: "https://github.com/binarybirds/swift-html", from: "1.7.0"),
		.package(url: "https://github.com/johnsundell/ink", from: "0.6.0")
	],
	targets: [
		.executableTarget(
			name: "alexandersandberg.com",
			dependencies: [
				.product(name: "Crypto", package: "swift-crypto"),
				.product(name: "SwiftHtml", package: "swift-html"),
				.product(name: "SwiftRss", package: "swift-html"),
				.product(name: "Ink", package: "ink")
			],
			resources: [
				.process("Resources")
			]
		),
	]
)
