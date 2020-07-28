//
//  LaguSionClient.swift
//  Networking
//
//  Created by Abram Situmorang on 27/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import CombineGRPC
import ComposableArchitecture
import GRPC

public protocol LaguSionClientProtocol {
    var listSongs: (Lagusion_ListSongRequest) -> Effect<Lagusion_ListSongResponse, GRPCStatus> { get }
}

public struct LaguSionClient: LaguSionClientProtocol {
    public var listSongs: (Lagusion_ListSongRequest) -> Effect<Lagusion_ListSongResponse, GRPCStatus>
    
    public init(listSongs: @escaping (Lagusion_ListSongRequest) -> Effect<Lagusion_ListSongResponse, GRPCStatus>) {
        self.listSongs = listSongs
    }
    
    public static var mock: LaguSionClient {
        LaguSionClient(
            listSongs: { (_) -> Effect<Lagusion_ListSongResponse, GRPCStatus> in
                return Effect(Just(Lagusion_ListSongResponse()).setFailureType(to: GRPCStatus.self))
            }
        )
    }
}
