//
//  LaguSionClient.swift
//  Networking
//
//  Created by Abram Situmorang on 27/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import CombineGRPC
import GRPC
import NIO

public protocol LaguSionGRPCClientProtocol {
    func listSongs(_ request: Lagusion_ListSongRequest) -> AnyPublisher<Lagusion_ListSongResponse, GRPCStatus>
}

public class DefaultLaguSionGRPCClient: LaguSionGRPCClientProtocol {
    let grpc: GRPCExecutor = GRPCExecutor()
    let eventLoopGroup: EventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    var channel: ClientConnection
    var client: Lagusion_LaguSionServiceClientProtocol
    
    public init(host: String, port: Int) {
        self.channel = ClientConnection
            .insecure(group: self.eventLoopGroup)
            .connect(host: host, port: port)
        self.client = Lagusion_LaguSionServiceClient(channel: channel)
    }
    
    public func listSongs(_ request: Lagusion_ListSongRequest) -> AnyPublisher<Lagusion_ListSongResponse, GRPCStatus> {
        return AnyPublisher(grpc.call(client.listSongs)(request))
    }
}

public class MockLaguSionGRPCClient: LaguSionGRPCClientProtocol {
    var listSongsFunc: ((Lagusion_ListSongRequest) -> AnyPublisher<Lagusion_ListSongResponse, GRPCStatus>)?
    public init(_ listSongsFunc: @escaping (Lagusion_ListSongRequest) -> AnyPublisher<Lagusion_ListSongResponse, GRPCStatus>) {
        self.listSongsFunc = listSongsFunc
    }
    
    public init() {
        self.listSongsFunc = nil
    }
    
    public func listSongs(_ request: Lagusion_ListSongRequest) -> AnyPublisher<Lagusion_ListSongResponse, GRPCStatus> {
        if let listSongsFunc = self.listSongsFunc {
            return listSongsFunc(request)
        }
        return AnyPublisher(Just(Lagusion_ListSongResponse()).setFailureType(to: GRPCStatus.self))
    }
}
