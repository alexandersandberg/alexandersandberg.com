// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "Website",
	dependencies: [
		.package(url: "https://github.com/binarybirds/swift-html", from: "1.7.0")
	],
	targets: [
		.executableTarget(
			name: "Website",
			dependencies: [
				.product(name: "SwiftHtml", package: "swift-html")
			]
		),
	]
)
