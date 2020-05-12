load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

exports_files(["LaguSion/ThirdParty/swift-nio-ssl/CNIOBoringSSL.modulemap"])

# swift_package_path = "LaguSion/DerivedData/LaguSion/SourcePackages/checkouts/"

# objc_library(
#     name = "CNIOLinux",
#     module_name = "CNIOLinux",
#     srcs = glob([swift_package_path + "swift-nio/Sources/CNIOLinux/*.c"]),
#     hdrs = glob([swift_package_path + "swift-nio/Sources/CNIOLinux/include/*.h"]),
#     includes = [swift_package_path + "swift-nio/Sources/CNIOLinux/include/"],
# )
#
# objc_library(
#     name = "CNIODarwin",
#     module_name = "CNIODarwin",
#     srcs = glob([swift_package_path + "swift-nio/Sources/CNIODarwin/*.c"]),
#     hdrs = glob([swift_package_path + "swift-nio/Sources/CNIODarwin/include/*.h"]),
#     includes = [swift_package_path + "swift-nio/Sources/CNIODarwin/include/"],
# )
#
# objc_library(
#     name = "CNIOAtomics",
#     module_name = "CNIOAtomics",
#     srcs = glob([swift_package_path + "swift-nio/Sources/CNIOAtomics/src/*.c"]),
#     hdrs = glob([swift_package_path + "swift-nio/Sources/CNIOAtomics/*/*.h"]),
# )
#
# cc_library(
#     name = "CNIOSHA1",
#     srcs = glob([swift_package_path + "swift-nio/Sources/CNIOSHA1/*.c"]),
#     hdrs = glob([swift_package_path + "swift-nio/Sources/CNIOSHA1/include/*.h"]),
# )
#
# swift_library(
#     name = "NIOConcurrencyHelpers",
#     srcs = glob([swift_package_path + "swift-nio/Sources/NIOConcurrencyHelpers/*.swift"]),
#     deps = [":CNIOAtomics"],
# )
#
# swift_library(
#     name = "NIO",
#     srcs = glob([swift_package_path + "swift-nio/Sources/NIO/*.swift"]),
#     deps = [
#         ":CNIOLinux",
#         ":CNIODarwin",
#         ":NIOConcurrencyHelpers",
#         ":CNIOAtomics",
#         ":CNIOSHA1",
#     ],
# )
#
# swift_library(
#     name = "NIOFoundationCompat",
#     srcs = glob([swift_package_path + "swift-nio/Sources/NIOFoundationCompat/*.swift"]),
#     deps = [":NIO"],
# )
#
# swift_library(
#     name = "NIOTransportServices",
#     srcs = glob([swift_package_path + "swift-nio-transport-services/Sources/NIOTransportServices/*.swift"]),
#     deps = [":NIO", ":NIOFoundationCompat", ":NIOConcurrencyHelpers", ":NIOTLS"]
# )
#
# objc_library(
#     name = "CNIOHTTPParser",
#     module_name = "CNIOHTTPParser",
#     srcs = glob([swift_package_path + "swift-nio/Sources/CNIOHTTPParser/*.c"]),
#     hdrs = glob([swift_package_path + "swift-nio/Sources/CNIOHTTPParser/include/*.h"]),
# )
#
# swift_library(
#     name = "NIOHTTP1",
#     srcs = glob([swift_package_path + "swift-nio/Sources/NIOHTTP1/*.swift"]),
#     deps = [":NIO", ":NIOConcurrencyHelpers", ":CNIOHTTPParser"],
# )
#
# swift_library(
#     name = "NIOTLS",
#     srcs = glob([swift_package_path + "swift-nio/Sources/NIOTLS/*.swift"]),
#     deps = [":NIO"],
# )

# swift_library(
#     name = "NIOHPACK",
#     srcs = glob([swift_package_path + "swift-nio-http2/Sources/NIOHPACK/*.swift"]),
#     deps = [":NIO", ":NIOConcurrencyHelpers", ":NIOHTTP1"],
# )
#
# swift_library(
#     name = "NIOHTTP2",
#     srcs = glob([
#         swift_package_path + "swift-nio-http2/Sources/NIOHTTP2/**/*.swift",
#     ]),
#     deps = [":NIO", ":NIOHTTP1", ":NIOTLS", ":NIOHPACK", ":NIOConcurrencyHelpers"],
# )

# objc_library(
#     name = "CNIOBoringSSL",
#     srcs = glob([
#         swift_package_path + "swift-nio-ssl/Sources/CNIOBoringSSL/**/*.c",
#         swift_package_path + "swift-nio-ssl/Sources/CNIOBoringSSL/**/*.cc",
#         swift_package_path + "swift-nio-ssl/Sources/CNIOBoringSSL/**/*.S",
#     ]),
#     hdrs = glob([
#         swift_package_path + "swift-nio-ssl/Sources/CNIOBoringSSL/**/*.h",
#     ]),
#     includes = [
#         swift_package_path + "swift-nio-ssl/Sources/CNIOBoringSSL/include/",
#     ],
#     module_map = "LaguSion/modulemaps/CNIOBoringSSL.modulemap",
#     visibility = ["//visibility:public"],
# )
#
# objc_library(
#     name = "CNIOBoringSSLShims",
#     module_name = "CNIOBoringSSLShims",
#     srcs = glob([swift_package_path + "swift-nio-ssl/Sources/CNIOBoringSSLShims/*.c"]),
#     hdrs = glob([swift_package_path + "swift-nio-ssl/Sources/CNIOBoringSSLShims/include/*.h"]),
#     includes = [swift_package_path + "swift-nio-ssl/Sources/CNIOBoringSSLShims/include/"],
#     deps = [":CNIOBoringSSL"],
#     visibility = ["//visibility:public"],
# )
#
# swift_library(
#     name = "NIOSSL",
#     srcs = glob([swift_package_path + "swift-nio-ssl/Sources/NIOSSL/*.swift"]),
#     deps = [
#         ":NIO", 
#         ":NIOConcurrencyHelpers", 
#         ":CNIOBoringSSLShims", 
#         ":NIOTLS"
#     ],
#     private_deps = [
#         ":CNIOBoringSSL", 
#     ],
# )

# objc_library(
#     name = "CGRPCZlib",
#     module_name = "CGRPCZlib",
#     srcs = glob([swift_package_path + "grpc-swift/Sources/CGRPCZlib/*.c"]),
#     hdrs = glob([swift_package_path + "grpc-swift/Sources/CGRPCZlib/include/*.h"]),
#     includes = [swift_package_path + "grpc-swift/Sources/CGRPCZlib/include/*.h"],
#     deps = ["@zlib"],
# )

# swift_library(
#     name = "SwiftProtobuf",
#     srcs = glob([swift_package_path + "swift-protobuf/Sources/SwiftProtobuf/*.swift"]),
# )
#
# swift_library(
#     name = "Logging",
#     srcs = glob([swift_package_path + "swift-log/Sources/Logging/*.swift"]),
# )

# swift_library(
#     name = "GRPC",
#     srcs = glob([
#         swift_package_path + "grpc-swift/Sources/GRPC/*.swift",
#         swift_package_path + "grpc-swift/Sources/GRPC/*/*.swift",
#     ]),
#     deps = [
#         ":NIO",
#         ":NIOFoundationCompat",
#         ":NIOTransportServices",
#         ":NIOHTTP1",
#         ":NIOHTTP2",
#         ":NIOSSL",
#         ":CGRPCZlib",
#         ":SwiftProtobuf",
#         ":Logging",
#     ],
# )

# swift_library(
#     name = "CombineGRPC",
#     srcs = glob([
#         swift_package_path + "grpc-swift-combine/Sources/*/*/*.swift",
#     ]),
#     deps = [":GRPC"],
# )

swift_library(
    name = "LaguSionSources",
    srcs = glob([
        "LaguSion/LaguSion/**/*.swift",
    ]),
    deps = [
        "@com_github_vyshane_grpc_swift_combine//:CombineGRPC"
    ],
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
