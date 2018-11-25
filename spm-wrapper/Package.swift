// swift-tools-version:4.0
import PackageDescription

let package = Package (
    name: "Fac",
    products: [
        .library(name: "Fac", targets: ["Fac"])
    ],
    targets: [
        .target(name: "libfac", dependencies: []),
        .target(name: "Fac", dependencies: ["libfac"]),
        .testTarget(name: "FacTests", dependencies: ["Fac"])
    ]
)
