//
//  SongBookSelectionTest.swift
//  MainTests
//
//  Created by Abram Situmorang on 28/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import ComposableArchitecture
import GRPC
import DataSource

import SwiftUI
import XCTest

@testable import Main

class SongBookSelectionTest: XCTestCase {
    let scheduler = DispatchQueue.testScheduler
    
    func testSongBookSelectionChanged() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.songBookPicked(.all)) {
                $0.selectedBook = .all
            },
            .receive(.getSongs),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.getSongsCompleted([])) {
                $0.songs = []
            },
            .send(.songBookPicked(.songBook(.laguSion))) {
                $0.selectedBook = .songBook(.laguSion)
            },
            .receive(.getSongs),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.getSongsCompleted([])) {
                $0.songs = []
            },
            .send(.songBookPicked(.songBook(.laguSionEdisiLengkap))) {
                $0.selectedBook = .songBook(.laguSionEdisiLengkap)
            },
            .receive(.getSongs),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.getSongsCompleted([])) {
                $0.songs = []
            }
        )
    }
}
