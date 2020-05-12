load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "LaguSionSources",
    srcs = glob([
        "LaguSion/LaguSion/*.swift",
        "LaguSion/LaguSion/Services/gRPC/*.swift",
        "LaguSion/LaguSion/Tools/*.swift",
        "LaguSion/LaguSion/UI/*/*.swift",
    ]),
)

ios_application(
    name = "LaguSion",
    bundle_id = "abrampers.LaguSion",
    families = [
        "iphone",
        "ipad",
    ],
    minimum_os_version = "13.0",
    infoplists = [":LaguSion/LaguSion/Bazel-Info.plist"],
    visibility = ["//visibility:public"],
    deps = [":LaguSionSources"],
)
