protoc -I Networking/gRPC/LaguSionService/ lagu_sion.proto --grpc-swift_out=Networking/gRPC/LaguSionService/ --grpc-swift_opt=Visibility=Public,Client=true,Server=false
protoc -I Networking/gRPC/LaguSionService/ lagu_sion.proto --swift_out=Networking/gRPC/LaguSionService/ --swift_opt=Visibility=Public
