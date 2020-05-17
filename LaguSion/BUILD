load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_apple//apple:versioning.bzl", "apple_bundle_version")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

filegroup(
    name = "Assets.xcassets",
    srcs = glob(["Assets.xcassets/**"]),
)

swift_library(
    name = "LaguSionSources",
    module_name = "LaguSion",
    srcs = glob([
        "SceneDelegate.swift",
        "AppDelegate.swift",
        "**/*.swift",
    ]),
    data = [
        "LaguSion.xcdatamodeld/LaguSion.xcdatamodel",
        ":Assets.xcassets",
    ],
    deps = [
        "@com_github_vyshane_grpc_swift_combine//:CombineGRPC",
        "@com_github_pointfreeco_swift_composable_architecture//:ComposableArchitecture",
    ],
    visibility = ["//visibility:public"],
)

ios_application(
    name = "LaguSion",
    bundle_id = "id.abram.ios.LaguSion",
    families = [
        "iphone",
        "ipad",
    ],
    minimum_os_version = "13.0",
    launch_storyboard = "Base.lproj/LaunchScreen.storyboard",
    infoplists = ["Info-Bazel.plist"],
    deps = [
        ":LaguSionSources",
    ],
    provisioning_profile = "provision/Development_id.abram.ios.LaguSion.mobileprovision",
    visibility = ["//visibility:public"],
)
