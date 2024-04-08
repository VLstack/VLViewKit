// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "VLViewKit",
                      platforms: [ .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLViewKit",
                                targets: [ "VLViewKit" ])
                      ],
                      targets:
                      [
                       .target(name: "VLViewKit"),
                       .testTarget(name: "VLViewKitTests",
                                   dependencies: [ "VLViewKit" ])
                      ])
