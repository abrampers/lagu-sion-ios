//
//  LaguSionDataSource.swift
//  DataSource
//
//  Created by Abram Perdanaputra on 30/09/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import Networking

public protocol LaguSionDataSourceProtocol {
    func listSongs(_ bookSelection: BookSelection, _ sortOptions: SortOptions) -> AnyPublisher<[Song], LaguSionError>
}

public class DefaultLaguSionDataSource: LaguSionDataSourceProtocol {
    let client: LaguSionGRPCClientProtocol
    
    public init(client: LaguSionGRPCClientProtocol) {
        self.client = client
    }
    
    public func listSongs(_ bookSelection: BookSelection, _ sortOptions: SortOptions) -> AnyPublisher<[Song], LaguSionError> {
        let request = Lagusion_ListSongRequest.with {
            $0.bookID = 0
            $0.sortOptions = .alphabet
        }
        return client.listSongs(request)
            .map { (response) -> [Song] in
                return response.songs.map { Song(pbSong: $0) }
            }
            .catch { _ -> AnyPublisher<[Song], LaguSionError> in
                return Just([])
                    .setFailureType(to: LaguSionError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

public class MockLaguSionDataSource: LaguSionDataSourceProtocol {
    var listSongsFunc: ((BookSelection, SortOptions) -> AnyPublisher<[Song], LaguSionError>)?
    
    public init(listSongsFunc: @escaping (BookSelection, SortOptions) -> AnyPublisher<[Song], LaguSionError>) {
        self.listSongsFunc = listSongsFunc
    }
    
    public init() {
        self.listSongsFunc = nil
    }
    
    public func listSongs(_ bookSelection: BookSelection, _ sortOptions: SortOptions) -> AnyPublisher<[Song], LaguSionError> {
        if let listSongsFunc = self.listSongsFunc {
            return listSongsFunc(bookSelection, sortOptions)
        }
        return Just([])
            .setFailureType(to: LaguSionError.self)
            .eraseToAnyPublisher()
    }
}
