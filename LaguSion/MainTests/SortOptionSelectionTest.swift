//
//  SortOptionSelectionTest.swift
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

class SortOptionSelectionTest: XCTestCase {
    let scheduler = DispatchQueue.testScheduler
    
    func testActionSheetDismissed() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionClient: LaguSionClient.mock
            )
        )
        
        store.assert(
            .send(.sortOptionTapped) {
                $0.actionSheet = ActionSheetState(
                    title: "Change sorting option",
                    buttons: [
                        .default("Song Number", send: .sortOptionChanged(.number)),
                        .default("Song Title", send: .sortOptionChanged(.alphabet)),
                        .cancel(send: .actionSheetDismissed)
                    ]
                )
            },
            .send(.actionSheetDismissed) {
                $0.actionSheet = nil
            }
        )
    }
    
    func testActionSheetNumber() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionClient: LaguSionClient.mock
            )
        )

        store.assert(
            .send(.sortOptionTapped) {
                $0.actionSheet = ActionSheetState(
                    title: "Change sorting option",
                    buttons: [
                        .default("Song Number", send: .sortOptionChanged(.number)),
                        .default("Song Title", send: .sortOptionChanged(.alphabet)),
                        .cancel(send: .actionSheetDismissed)
                    ]
                )
            },
            .send(.sortOptionChanged(.number)) {
                $0.selectedSortOption = .number
                $0.actionSheet = nil
            },
            .receive(.getSongs),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.getSongsCompleted([])) {
                $0.songs = []
            }
        )
    }
    
    func testActionSheetAlphabet() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionClient: LaguSionClient.mock
            )
        )
        
        store.assert(
            .send(.sortOptionTapped) {
                $0.actionSheet = ActionSheetState(
                    title: "Change sorting option",
                    buttons: [
                        .default("Song Number", send: .sortOptionChanged(.number)),
                        .default("Song Title", send: .sortOptionChanged(.alphabet)),
                        .cancel(send: .actionSheetDismissed)
                    ]
                )
            },
            .send(.sortOptionChanged(.alphabet)) {
                $0.selectedSortOption = .alphabet
                $0.actionSheet = nil
            },
            .receive(.getSongs),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.getSongsCompleted([])) {
                $0.songs = []
            }
        )
    }
}