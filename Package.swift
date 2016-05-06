import PackageDescription

let package = Package(
	name: "HTTPSerializer",
	dependencies: [
        .Package(url: "https://github.com/open-swift/S4.git", majorVersion: 0, minor: 6),
    ]
)
