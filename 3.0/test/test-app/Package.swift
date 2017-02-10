import PackageDescription

let package = Package(
  name:  "test-app",
  dependencies: [
    .Package(url:  "./Packages/ClibBSD", majorVersion: 1),
  ]
)

// Alternative location for dependency:
//.Package(url:  "https://github.com/dudash/swift-package-clibbsd.git", majorVersion: 1),
