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
    func testHeartTapped() {
        let store = TestStore(
            initialState: Song(id: UUID(), number: 0, title: "", verses: [], songBook: .laguSion),
            reducer: songReducer,
            environment: SongEnvironment()
        )
        
        store.assert(
            .send(.heartTapped),
            .receive(.addToFavorites) {
                $0.isFavorite = true
            },
            .send(.heartTapped),
            .receive(.removeFromFavorites) {
                $0.isFavorite = false
            },
            .send(.heartTapped),
            .receive(.addToFavorites) {
                $0.isFavorite = true
            }
        )
    }
}
