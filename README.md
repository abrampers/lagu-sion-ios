# Lagu Sion iOS

[![bazel-build](https://github.com/abrampers/lagu-sion-ios/workflows/bazel-build/badge.svg?branch=master)](https://github.com/abrampers/lagu-sion-ios/actions?query=workflow%3Abazel-build)

Lagu Sion iOS reader app

## Dev Environment Setup

Install latest version of Xcode.

## Architecture

This is built using:
- SwiftUI + [Point-Free's The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture).
- [gRPC](https://grpc.io) for communication layer. Specifically [gRPC Swift Combine](https://github.com/vyshane/grpc-swift-combine).
- [bazel](https://www.bazel.build) for GitHub actions build system.

Packages:
- LaguSion: Main App
- Song: Song screen
- Main: Main screen that shows the list of songs, search songs, filter songs, and sort songs
- Favorites: List of favorite songs
- Common: Common code used throughout the app
- Settings: Settings page to modify font size, font type, offline mode (TODO)
- DataSource: Data source abstraction. Handles the conversion between networking format and application model format
- Networking: Handles all gRPC call
