import PackageDescription

let package = Package(
  name:  "app",
  dependencies: [
    .Package(url: "./LocalPackages/ClibBSD", majorVersion: 1)
  ]
)

// Alternative location for ClibBSD dependency:
//.Package(url:  "https://github.com/dudash/swift-package-clibbsd.git", majorVersion: 1),
