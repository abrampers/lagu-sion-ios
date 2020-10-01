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
            initialState: Song(id: UUID(), number: 0, title: "", verses: [], songBook: .laguSion),
            reducer: songReducer,
            environment: SongEnvironment()
        )
        
        store.assert(
            .send(.heartTapped),
            .receive(.addToFavorites) {
                $0.isFavorite = true
            }
            
        )
    }
    
    func testHeartTapped_WithIsFavorite_True() {
        var song = Song(id: UUID(), number: 0, title: "", verses: [], songBook: .laguSion)
        song.isFavorite = true
        
        let store = TestStore(
            initialState: song,
            reducer: songReducer,
            environment: SongEnvironment()
        )
        
        store.assert(
            .send(.heartTapped),
            .receive(.removeFromFavorites) {
                $0.isFavorite = false
            }
        )
    }
}
