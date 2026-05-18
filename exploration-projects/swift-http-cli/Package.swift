// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "swift-http-cli",
    platforms: [
        .macOS(.v13),
    ],
    targets: [
        .executableTarget(name: "swift-http-cli"),
    ]
)
