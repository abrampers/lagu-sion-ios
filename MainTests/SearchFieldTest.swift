//
//  SearchFieldTest.swift
//  MainTests
//
//  Created by Abram Situmorang on 28/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import ComposableArchitecture
import GRPC
import Networking

import SwiftUI
import XCTest

@testable import Main

class SearchFieldTest: XCTestCase {
    let scheduler = DispatchQueue.testScheduler
    
    func testSearchFieldChanged() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionClient: LaguSionClient.mock
            )
        )
        
        store.assert(
            .send(.searchQueryChanged("Test")),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.saveSearchQuery("Test")) {
                $0.searchQuery = "Test"
            }
        )
    }
    
    func testSearchFieldChangedCanceled() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionClient: LaguSionClient.mock
            )
        )
        
        store.assert(
            .send(.searchQueryChanged("Test")),
            .do { self.scheduler.advance(by: 0.11) },
            .send(.searchQueryChanged("This is it")),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.saveSearchQuery("This is it")) {
                $0.searchQuery = "This is it"
            }
        )
    }
}
