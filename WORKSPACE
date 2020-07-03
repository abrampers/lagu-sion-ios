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
    name = "com_github_vyshane_grpc_swift_combine",
    remote = "https://github.com/vyshane/grpc-swift-combine.git",
    commit = "186d27cd0c33b83ee2b6422bf551dfc7c8d9914f", # tag = "0.13.0",
    shallow_since = "1591883999 +0800",
    build_file = "@//:third_party/CombineGRPC/BUILD.combine-grpc",
)

new_git_repository(
    name = "com_github_grpc_grpc_swift_local",
    remote = "https://github.com/grpc/grpc-swift.git",
    commit = "399cfe1cfec19d8dc37dcd945a389e6eaae3ea43", # tag = "1.0.0-alpha.14",
    shallow_since = "1591812517 +0100",
    build_file = "@//:third_party/grpc-swift/BUILD.grpc-swift",
)

new_git_repository(
    name = "com_github_apple_swift_protobuf_local",
    remote = "https://github.com/apple/swift-protobuf.git",
    commit = "7790acf0a81d08429cb20375bf42a8c7d279c5fe", # tag = "1.8.0",
    shallow_since = "1580243347 -0500",
    build_file = "@//:third_party/SwiftProtobuf/BUILD.swift-protobuf",
)

new_git_repository(
    name = "com_github_apple_swift_log",
    remote = "https://github.com/apple/swift-log.git",
    commit = "74d7b91ceebc85daf387ebb206003f78813f71aa", # tag = "1.2.0",
    shallow_since = "1570831114 -0700",
    build_file = "@//:third_party/swift-log/BUILD.swift-log",
)

new_git_repository(
    name = "com_github_apple_swift_nio",
    remote = "https://github.com/apple/swift-nio.git",
    commit = "c5fa0b456524cd73dc3ddbb263d4f46c20b86ca3", # tag = "2.17.0",
    shallow_since = "1589271116 +0100",
    build_file = "@//:third_party/swift-nio/BUILD.swift-nio",
)

new_git_repository(
    name = "com_github_apple_swift_nio_http2",
    remote = "https://github.com/apple/swift-nio-http2.git",
    commit = "b66a08e4bc53ab7c39fb03ab3678132e6ba5d12d", # tag = "1.12.0",
    shallow_since = "1589200136 +0100",
    build_file = "@//:third_party/swift-nio-http2/BUILD.swift-nio-http2",
)

new_git_repository(
    name = "com_github_apple_swift_nio_ssl",
    remote = "https://github.com/apple/swift-nio-ssl.git",
    commit = "67303bd6d8c8b2bb69c44626156cfe802d6cff28", # tag = "2.7.2",
    shallow_since = "1588664993 +0100",
    build_file = "@//:third_party/swift-nio-ssl/BUILD.swift-nio-ssl",
)

new_git_repository(
    name = "com_github_apple_swift_nio_transport_services",
    remote = "https://github.com/apple/swift-nio-transport-services.git",
    commit = "85a67aea7caf5396ed599543dd23cffeb6dbbf96", # tag = "1.5.1",
    shallow_since = "1585934605 +0100",
    build_file = "@//:third_party/swift-nio-transport-service/BUILD.swift-nio-transport-service",
)
