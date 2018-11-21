// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Tyler.Substitutes",
    products: [
        .library(name: "Tyler.Substitutes", targets: ["Substitutes"]),
    ],
    dependencies: [
        .package(url: "https://github.com/IgorMuzyka/Tyler.Style", .branch("master")),
        .package(url: "https://github.com/IgorMuzyka/Tyler.Tag", .branch("master")),
    ],
    targets: [
        .target(name: "Substitutes", dependencies: ["Tyler.Tag", "Tyler.Style"]),
    ]
)
