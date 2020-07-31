//
//  Core.swift
//  LaguSion
//
//  Created by Abram Situmorang on 27/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import CombineGRPC
import GRPC
import Networking
import NIO

let grpc = GRPCExecutor()
let eventLoopGroup: EventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
let channel: ClientConnection = ClientConnection
    .insecure(group: eventLoopGroup)
    .connect(host: Constants.laguSionHost, port: Constants.laguSionPort)
let client = Lagusion_LaguSionServiceClient(channel: channel)

fileprivate func liveListSong(request: Lagusion_ListSongRequest) -> AnyPublisher<Lagusion_ListSongResponse, GRPCStatus> {
    return AnyPublisher(grpc.call(client.listSongs)(request))
}

extension LaguSionClient {
    static var liveLaguSionClient: LaguSionClient {
        LaguSionClient(listSongs: liveListSong(request:))
    }
}
