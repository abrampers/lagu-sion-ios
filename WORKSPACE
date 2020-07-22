load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

git_repository(
    name = "build_bazel_rules_apple",
    remote = "https://github.com/bazelbuild/rules_apple.git",
    commit = "193d258479e891bf286bf884d52ac779c83be206",
    shallow_since = "1589211273 -0700",
)

git_repository(
    name = "build_bazel_rules_swift",
    remote = "https://github.com/bazelbuild/rules_swift.git",
    commit = "35ef1d6ebd7adb8d20c096bb4355cf41c9a0b5cf",
    shallow_since = "1588778892 -0700",
)

git_repository(
    name = "build_bazel_apple_support",
    remote = "https://github.com/bazelbuild/apple_support.git",
    commit = "501b4afb27745c4813a88ffa28acd901408014e4",
    shallow_since = "1577729628 -0800",
)

git_repository(
    name = "bazel_skylib",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
    commit = "e59b620b392a8ebbcf25879fc3fde52b4dc77535",
    shallow_since = "1570639401 -0400",
)

load(
    "@build_bazel_rules_apple//apple:repositories.bzl",
    "apple_rules_dependencies",
)

apple_rules_dependencies()

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()

load(
    "@build_bazel_apple_support//lib:repositories.bzl",
    "apple_support_dependencies",
)

apple_support_dependencies()

load(
    "@com_google_protobuf//:protobuf_deps.bzl",
    "protobuf_deps",
)

protobuf_deps()

# Third party dependencies

## ComposableArchitecture
new_git_repository(
    name = "com_github_pointfreeco_swift_composable_architecture",
    remote = "https://github.com/pointfreeco/swift-composable-architecture.git",
    commit = "b8c67d5d4f27ad3b2f772cf50f91c581fc94611c", # tag = "0.6.0",
    shallow_since = "1593528579 +0000",
    build_file = "@//:third_party/swift-composable-architecture/BUILD.swift-composable-architecture",
)

new_git_repository(
    name = "com_github_pointfreeco_combine_schedulers",
    remote = "https://github.com/pointfreeco/combine-schedulers",
    commit = "afc84b6a3639198b7b8b6d79f04eb3c2ee590d29", # tag = "0.1.1",
    shallow_since = "1592312675 +0000",
    build_file = "@//:third_party/combine-schedulers/BUILD.combine-schedulers",
)

new_git_repository(
    name = "com_github_pointfreeco_swift_case_paths",
    remote = "https://github.com/pointfreeco/swift-case-paths.git",
    commit = "fb733d87aabb5b053ad782902f2f3d67e0a65ac5", # tag = "0.1.1",
    shallow_since = "1589381871 -0400",
    build_file = "@//:third_party/swift-case-paths/BUILD.swift-case-paths",
)

## CombineGRPC
new_git_repository(
    name = "com_github_abrampers_grpc_swift_combine",
    remote = "https://github.com/abrampers/grpc-swift-combine.git",
    commit = "b50a12eff4e98679ea6b85516705704412e90bc3", # tag = "0.14.0",
    shallow_since = "1595401763 +0700",
    build_file = "@//:third_party/CombineGRPC/BUILD.combine-grpc",
)

new_git_repository(
    name = "com_github_grpc_grpc_swift_local",
    remote = "https://github.com/grpc/grpc-swift.git",
    commit = "e461a8487b5bd0d8eef0ebf56f7d41401d9ff5ae", # tag = "1.0.0-alpha.16",
    shallow_since = "1594137828 +0100",
    build_file = "@//:third_party/grpc-swift/BUILD.grpc-swift",
)

new_git_repository(
    name = "com_github_apple_swift_protobuf_local",
    remote = "https://github.com/apple/swift-protobuf.git",
    commit = "7f36441e3372665b1b414f8ac93b5905cc42a405", # tag = "1.9.0",
    shallow_since = "1589825556 -0400",
    build_file = "@//:third_party/SwiftProtobuf/BUILD.swift-protobuf",
)

new_git_repository(
    name = "com_github_apple_swift_log",
    remote = "https://github.com/apple/swift-log.git",
    commit = "173f567a2dfec11d74588eea82cecea555bdc0bc", # tag = "1.4.0",
    shallow_since = "1594181143 +0900",
    build_file = "@//:third_party/swift-log/BUILD.swift-log",
)

new_git_repository(
    name = "com_github_apple_swift_nio",
    remote = "https://github.com/apple/swift-nio.git",
    commit = "120acb15c39aa3217e9888e515de160378fbcc1e", # tag = "2.18.0",
    shallow_since = "1591609580 +0100",
    build_file = "@//:third_party/swift-nio/BUILD.swift-nio",
)

new_git_repository(
    name = "com_github_apple_swift_nio_http2",
    remote = "https://github.com/apple/swift-nio-http2.git",
    commit = "c5d10f4165128c3d0cc0e3c0f0a8ef55947a73a6", # tag = "1.12.2",
    shallow_since = "1591798709 +0100",
    build_file = "@//:third_party/swift-nio-http2/BUILD.swift-nio-http2",
)

new_git_repository(
    name = "com_github_apple_swift_nio_ssl",
    remote = "https://github.com/apple/swift-nio-ssl.git",
    commit = "d381bc53edd9de88a75480a2b969bfc26d61ee76", # tag = "2.8.0",
    shallow_since = "1593526561 +0100",
    build_file = "@//:third_party/swift-nio-ssl/BUILD.swift-nio-ssl",
)

new_git_repository(
    name = "com_github_apple_swift_nio_transport_services",
    remote = "https://github.com/apple/swift-nio-transport-services.git",
    commit = "2ac8fde712c1b1a147ecb7065824a40d2c09d0cb", # tag = "1.6.0",
    shallow_since = "1591635028 +0100",
    build_file = "@//:third_party/swift-nio-transport-service/BUILD.swift-nio-transport-service",
)
