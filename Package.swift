import PackageDescription

let package = Package(
    name: "minotaur",
    dependencies: [
        .Package(url: "https://github.com/kyouko-taiga/LogicKit",
                 majorVersion: 0),
    ]
)
