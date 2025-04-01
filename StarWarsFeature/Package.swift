// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "StarWarsFeature",
	platforms: [.iOS(.v16)],
	products: [
		.library(
			name: "StarWarsFeature",
			targets: ["StarWarsFeature"]),
	],
	targets: [
		.target(
			name: "StarWarsFeature"),
		.testTarget(
			name: "StarWarsFeatureTests",
			dependencies: ["StarWarsFeature"]
		),
	]
)
