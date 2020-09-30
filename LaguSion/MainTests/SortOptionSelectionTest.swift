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
import DataSource

import SwiftUI
import XCTest

@testable import Main

class SortOptionSelectionTest: XCTestCase {
    let scheduler = DispatchQueue.testScheduler
    var store: TestStore<MainState, MainState, MainAction, MainAction, MainEnvironment>!
    
    override func setUp() {
        self.store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
    }
    
    func testActionSheetDismissed() {
        self.store.assert(
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
        self.store.assert(
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
        self.store.assert(
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
