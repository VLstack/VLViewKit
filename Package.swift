// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "VLViewKit",
                      platforms: [ .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLViewKit",
                                targets: [ "VLViewKit" ])
                      ],
                      dependencies:
                      [
                       .package(url: "https://github.com/VLstack/VLstackNamespace", from: "1.1.1")
                      ],
                      targets:
                      [
                       .target(name: "VLViewKit",
                               dependencies: [ "VLstackNamespace" ])
                      ])
