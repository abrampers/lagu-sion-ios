load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "LaguSionSources",
    srcs = glob([
        "**/*.swift",
    ]),
    deps = [
        "@com_github_vyshane_grpc_swift_combine//:CombineGRPC"
    ],
)

ios_application(
    name = "LaguSion",
    bundle_id = "id.abram.ios.LaguSion",
    families = [
        "iphone",
        "ipad",
    ],
    minimum_os_version = "13.0",
    infoplists = ["Bazel-Info.plist"],
    visibility = ["//visibility:public"],
    deps = [":LaguSionSources"],
)
