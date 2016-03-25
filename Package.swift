import PackageDescription

let package = Package(
	name: "HTTPSerializer",
	dependencies: [
        .Package(url: "https://github.com/Zewo/Data.git", majorVersion: 0, minor: 4),
        .Package(url: "https://github.com/swiftx/s4.git", majorVersion: 0, minor: 1)
    ]
)
