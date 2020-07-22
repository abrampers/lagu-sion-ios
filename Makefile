PROTO_DIR = Networking/gRPC/protobuf
PROTO_GEN_DIR = Networking/gRPC/Generated
PROTOC_PATH= third_party/protoc/bin/protoc
PROTOC_PLUGIN_PATH= third_party/protoc/protoc-grpc-swift-plugins-1.0.0-alpha.16
PROTOC_SWIFT_PLUGIN_PATH= ${PROTOC_PLUGIN_PATH}/bin/protoc-gen-swift
PROTOC_GRPC_SWIFT_PLUGIN_PATH= ${PROTOC_PLUGIN_PATH}/bin/protoc-gen-grpc-swift

protobuf:
	mkdir -p ${PROTO_GEN_DIR}
	${PROTOC_PATH} ${PROTO_DIR}/*.proto \
		--plugin=${PROTOC_SWIFT_PLUGIN_PATH} \
		--swift_out=Visibility=Public,FileNaming=DropPath:${PROTO_GEN_DIR}
	${PROTOC_PATH} ${PROTO_DIR}/*.proto \
		--plugin=${PROTOC_GRPC_SWIFT_PLUGIN_PATH} \
		--grpc-swift_out=Visibility=Public,Client=true,Server=false,TestClient=true,FileNaming=DropPath:${PROTO_GEN_DIR}
# ./third_party/protoc/bin/protoc -I Networking/gRPC/LaguSionService/ \
#   --plugin=third_party/bin/protoc-gen-grpc-swift \
#   --grpc-swift_out=Networking/gRPC/LaguSionService/ \
#   --grpc-swift_opt=Visibility=Public,Client=true,Server=false \
#   lagu_sion.proto
# ./third_party/protoc/bin/protoc -I Networking/gRPC/LaguSionService/ \
#   --plugin=third_party/bin/protoc-gen-swift \
#   --swift_out=Networking/gRPC/LaguSionService/ \
#   --swift_opt=Visibility=Public \
#   lagu_sion.proto
