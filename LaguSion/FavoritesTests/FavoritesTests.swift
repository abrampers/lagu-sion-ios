//
//  FavoritesTests.swift
//  FavoritesTests
//
//  Created by Abram Situmorang on 24/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import DataSource

import XCTest
@testable import Favorites

class FavoritesTests: XCTestCase {
    let scheduler = DispatchQueue.testScheduler
    let songs = [
        Song(id: UUID(), number: 0, title: "", verses: [], songBook: .laguSion),
        Song(id: UUID(), number: 1, title: "", verses: [], songBook: .laguSion),
        Song(id: UUID(), number: 2, title: "", verses: [], songBook: .laguSion),
        Song(id: UUID(), number: 3, title: "", verses: [], songBook: .laguSion),
        Song(id: UUID(), number: 4, title: "", verses: [], songBook: .laguSion),
        Song(id: UUID(), number: 1, title: "", verses: [], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 2, title: "", verses: [], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 3, title: "", verses: [], songBook: .laguSionEdisiLengkap),
    ]
    
    func testRemoveFavorite() {
        let store = TestStore(
            initialState:FavoritesState(
                songs: self.songs,
                favoriteSongs: [self.songs[0], self.songs[3]]
            ),
            reducer: favoritesReducer,
            environment: FavoritesEnvironment()
        )
        
        store.assert(
            .send(.deleteFavoriteSongs(IndexSet(integer: 0))),
            .receive(.updateFavoriteSongs([self.songs[3]])) {
                $0.favoriteSongs = [self.songs[3]]
            },
            .send(.deleteFavoriteSongs(IndexSet(integer: 0))),
            .receive(.updateFavoriteSongs([])) {
                $0.favoriteSongs = []
            }
        )
    }
}
