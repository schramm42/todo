// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "todo",
    dependencies: [
        // .package(url: "https://github.com/nsomar/Guaka.git", from: "0.0.0"),
        // .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.14.1"),
        .package(url: "https://github.com/getGuaka/Prompt.git", from: "0.0.0"),
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "6.0.0"),
        // .package(url: "https://github.com/scottrhoyt/SwiftyTextTable.git", from: "0.5.0"),
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", from: "1.5.0"),
        // .package(url: "https://github.com/Teknasyon-Teknoloji/PersistenceKit.git", from: "1.4.0"),
        .package(
            url: "https://github.com/JanGorman/Table",
            from: "1.0.0"
        ),
        // .package(url: "https://github.com/Swiftline/Swiftline.git", majorVersion: 0, minor: 3),
        // .package(url: "https://github.com/omaralbeik/Stores.git", from: "1.0.0"),
        // .package(url: "https://github.com/saoudrizwan/Disk.git", from: "0.6.4"),
    ],
    targets: [
        .target(
            name: "todo",
            dependencies: [
                "SwiftCLI", 
                // "SQLite", 
                "Prompt", 
                // "SwiftyTextTable",
                "ColorizeSwift",
                "Table",
                // "Swiftline",
                // "PersistenceKit",
                // "Stores",
                // "Disk",
            ]),
    ]
)
