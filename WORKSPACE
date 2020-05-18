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
    tag = "0.1.4",
    build_file = "@//:third_party/swift-composable-architecture/BUILD.swift-composable-architecture",
)

new_git_repository(
    name = "com_github_pointfreeco_swift_case_paths",
    remote = "https://github.com/pointfreeco/swift-case-paths.git",
    tag = "0.1.1",
    build_file = "@//:third_party/swift-case-paths/BUILD.swift-case-paths",
)

## CombineGRPC
new_git_repository(
    name = "com_github_vyshane_grpc_swift_combine",
    remote = "https://github.com/vyshane/grpc-swift-combine.git",
    tag = "0.10.0",
    build_file = "@//:third_party/CombineGRPC/BUILD.combine-grpc",
)

new_git_repository(
    name = "com_github_grpc_grpc_swift_local",
    remote = "https://github.com/grpc/grpc-swift.git",
    tag = "1.0.0-alpha.11",
    build_file = "@//:third_party/grpc-swift/BUILD.grpc-swift",
)

new_git_repository(
    name = "com_github_apple_swift_nio",
    remote = "https://github.com/apple/swift-nio.git",
    tag = "2.14.0",
    build_file = "@//:third_party/swift-nio/BUILD.swift-nio",
)

new_git_repository(
    name = "com_github_apple_swift_nio_http2",
    remote = "https://github.com/apple/swift-nio-http2.git",
    tag = "1.8.0",
    build_file = "@//:third_party/swift-nio-http2/BUILD.swift-nio-http2",
)

new_git_repository(
    name = "com_github_apple_swift_nio_ssl",
    remote = "https://github.com/apple/swift-nio-ssl.git",
    tag = "2.6.2",
    build_file = "@//:third_party/swift-nio-ssl/BUILD.swift-nio-ssl",
)

new_git_repository(
    name = "com_github_apple_swift_nio_transport_services",
    remote = "https://github.com/apple/swift-nio-transport-services.git",
    tag = "1.3.0",
    build_file = "@//:third_party/swift-nio-transport-service/BUILD.swift-nio-transport-service",
)

new_git_repository(
    name = "com_github_apple_swift_protobuf_local",
    remote = "https://github.com/apple/swift-protobuf.git",
    tag = "1.8.0",
    build_file = "@//:third_party/SwiftProtobuf/BUILD.swift-protobuf",
)

new_git_repository(
    name = "com_github_apple_swift_log",
    remote = "https://github.com/apple/swift-log.git",
    tag = "1.0.0",
    build_file = "@//:third_party/swift-log/BUILD.swift-log",
)
