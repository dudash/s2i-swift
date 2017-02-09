import PackageDescription

let package = Package(
  name:  "app",
  dependencies: [
    .Package(url:  "https://github.com/dudash/swift-package-clibbsd.git", majorVersion: 1),
  ]
)