load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
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
        ":Assets.xcassets",
    ] + glob(["LaguSion.xcdatamodeld/**"]),
    deps = [
        "@com_github_vyshane_grpc_swift_combine//:CombineGRPC",
        "@com_github_pointfreeco_swift_composable_architecture//:ComposableArchitecture",
    ],
    visibility = ["//visibility:public"],
)

config_setting(
    name = "debug_build",
    values = {
        "compilation_mode": "dbg",
    },
)

config_setting(
    name = "opt_build",
    values = {
        "compilation_mode": "opt",
    },
)

config_setting(
    name = "fastbuild_build",
    values = {
        "compilation_mode": "fastbuild",
    },
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
    provisioning_profile = select({
        ":debug_build": "provision/Development_id.abram.ios.LaguSion.mobileprovision",
        ":opt_build": "provision/AdHoc_id.abram.ios.LaguSion.mobileprovision",
        ":fastbuild_build": "provision/Development_id.abram.ios.LaguSion.mobileprovision",
    }, no_match_error = "Please specify compilation mode."),
    # provisioning_profile = "provision/AdHoc_id.abram.ios.LaguSion.mobileprovision",
    # provisioning_profile = "provision/Development_id.abram.ios.LaguSion.mobileprovision",
    visibility = ["//visibility:public"],
)
