// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Middleware",
    products: [
        .library(
            name: "Middleware",
            targets: ["Middleware"]),
    ],
    targets: [
        .target(
            name: "Middleware",
            dependencies: []),
        .testTarget(
            name: "MiddlewareTests",
            dependencies: ["Middleware"]),
    ]
)
