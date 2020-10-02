//
//  AppearTest.swift
//  MainTests
//
//  Created by Abram Perdanaputra on 01/10/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import DataSource

import XCTest
@testable import Main

class AppearTest: XCTestCase {
    let scheduler = DispatchQueue.testScheduler
    
    func testGetSongsEmpty() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.appear),
            .receive(.getSongs),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.setSongs([])) {
                $0.songs = []
            }
        )
    }
}
