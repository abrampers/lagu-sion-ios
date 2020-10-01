load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

git_repository(
    name = "build_bazel_rules_apple",
    remote = "https://github.com/bazelbuild/rules_apple.git",
    commit = "6ee60b3827bd6b1cf2822279b1402243c34af63c",
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
    commit = "47a9d368d1f314a630bf91b71acfb5054420eeb3", # tag = "0.8.0",
    build_file = "@//:third_party/swift-composable-architecture/BUILD.swift-composable-architecture",
)

new_git_repository(
    name = "com_github_pointfreeco_combine_schedulers",
    remote = "https://github.com/pointfreeco/combine-schedulers",
    commit = "afc84b6a3639198b7b8b6d79f04eb3c2ee590d29", # tag = "0.1.1",
    build_file = "@//:third_party/combine-schedulers/BUILD.combine-schedulers",
)

new_git_repository(
    name = "com_github_pointfreeco_swift_case_paths",
    remote = "https://github.com/pointfreeco/swift-case-paths.git",
    commit = "fb733d87aabb5b053ad782902f2f3d67e0a65ac5", # tag = "0.1.1",
    build_file = "@//:third_party/swift-case-paths/BUILD.swift-case-paths",
)

## CombineGRPC
new_git_repository(
    name = "com_github_vyshane_grpc_swift_combine",
    remote = "https://github.com/vyshane/grpc-swift-combine.git",
    commit = "ba5e65224eba58427d8bc9647641316c9efa1a55", # tag = "0.18.0",
    build_file = "@//:third_party/CombineGRPC/BUILD.combine-grpc",
)

new_git_repository(
    name = "com_github_combinecommunity_combineext",
    remote = "https://github.com/CombineCommunity/CombineExt.git",
    commit = "6664678135c6aec049c887a51c9da2545f184882", # tag = "1.2.0"
    build_file = "@//:third_party/CombineExt/BUILD.combine-ext",
)

new_git_repository(
    name = "com_github_grpc_grpc_swift_local",
    remote = "https://github.com/grpc/grpc-swift.git",
    commit = "640b0ef1d0be63bda0ada86786cfda678ab2aae9", # tag = "1.0.0-alpha.19",
    build_file = "@//:third_party/grpc-swift/BUILD.grpc-swift",
)

new_git_repository(
    name = "com_github_apple_swift_protobuf_local",
    remote = "https://github.com/apple/swift-protobuf.git",
    commit = "0279688c9fc5a40028e1b5bb0cb56534a45a6020", # tag = "1.12.0",
    build_file = "@//:third_party/SwiftProtobuf/BUILD.swift-protobuf",
)

new_git_repository(
    name = "com_github_apple_swift_log",
    remote = "https://github.com/apple/swift-log.git",
    commit = "173f567a2dfec11d74588eea82cecea555bdc0bc", # tag = "1.4.0",
    build_file = "@//:third_party/swift-log/BUILD.swift-log",
)

new_git_repository(
    name = "com_github_apple_swift_nio",
    remote = "https://github.com/apple/swift-nio.git",
    commit = "5fc24345f92ec4c274121776c215ab0aa1ed4d50", # tag = "2.22.0",
    build_file = "@//:third_party/swift-nio/BUILD.swift-nio",
)

new_git_repository(
    name = "com_github_apple_swift_nio_http2",
    remote = "https://github.com/apple/swift-nio-http2.git",
    commit = "1e68e51752be0b43c5a0ef35818c1dd24d13e77c", # tag = "1.14.2",
    build_file = "@//:third_party/swift-nio-http2/BUILD.swift-nio-http2",
)

new_git_repository(
    name = "com_github_apple_swift_nio_ssl",
    remote = "https://github.com/apple/swift-nio-ssl.git",
    commit = "ea1dfd64193bf5af4490635a4a44c4fb43b1e1ae", # tag = "2.9.1",
    build_file = "@//:third_party/swift-nio-ssl/BUILD.swift-nio-ssl",
)

new_git_repository(
    name = "com_github_apple_swift_nio_transport_services",
    remote = "https://github.com/apple/swift-nio-transport-services.git",
    commit = "bb56586c4cab9a79dce6ec4738baddb5802c5de7", # tag = "1.9.0",
    build_file = "@//:third_party/swift-nio-transport-service/BUILD.swift-nio-transport-service",
)
