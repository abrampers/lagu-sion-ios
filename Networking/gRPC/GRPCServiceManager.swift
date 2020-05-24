//
//  GRPCServiceManager.swift
//  LaguSion
//
//  Created by Abram Situmorang on 11/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import CombineGRPC
import GRPC
import NIO

public class GRPCServiceManager {
    public static var shared = GRPCServiceManager()
    public var executor: GRPCExecutor
    
    internal var echoClient: EchoServiceClient
    
    public init() {
        let eventLoopGroup = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        let channel = ClientConnection
          .insecure(group: eventLoopGroup)
          .connect(host: "localhost", port: 8080)
        self.echoClient = EchoServiceClient(channel: channel)
        self.executor = GRPCExecutor()
    }
}
