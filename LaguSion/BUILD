load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "LaguSionSources",
    srcs = glob([
        "**/*.swift",
    ]),
    deps = [
        "@com_github_vyshane_grpc_swift_combine//:CombineGRPC",
        "@com_github_pointfreeco_swift_composable_architecture//:ComposableArchitecture",
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
    infoplists = ["Info-Bazel.plist"],
    visibility = ["//visibility:public"],
    deps = [":LaguSionSources"],
    provisioning_profile = "provision/Development_id.abram.ios.LaguSion.mobileprovision",
)
