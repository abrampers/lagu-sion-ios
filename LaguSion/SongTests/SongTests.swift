//
//  SongTests.swift
//  SongTests
//
//  Created by Abram Situmorang on 24/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import DataSource

import XCTest
@testable import Song

class SongTests: XCTestCase {
    func testHeartTapped_WithIsFavorite_False() {
        let store = TestStore(
            initialState: SongViewState(
                song: Song(id: UUID(), number: 0, title: "", verses: [], songBook: .laguSion),
                isFavorite: false
            ),
            reducer: songReducer,
            environment: SongEnvironment()
        )
        
        store.assert(
            .send(.heartTapped),
            .receive(.addToFavorites)
        )
    }
    
    func testHeartTapped_WithIsFavorite_True() {
        let store = TestStore(
            initialState: SongViewState(
                song: Song(id: UUID(), number: 0, title: "", verses: [], songBook: .laguSion),
                isFavorite: true
            ),
            reducer: songReducer,
            environment: SongEnvironment()
        )
        
        store.assert(
            .send(.heartTapped),
            .receive(.removeFromFavorites)
        )
    }
}
