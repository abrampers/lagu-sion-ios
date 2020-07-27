//
//  ActionSheetAndAlertTest.swift
//  ActionSheetAndAlertTest
//
//  Created by Abram Situmorang on 24/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import ComposableArchitecture
import GRPC
import SwiftUI
import XCTest

@testable import Main

class ActionSheetAndAlertTest: XCTestCase {
    let scheduler = DispatchQueue.testScheduler
    
    func testAlert() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionClient: .mock
            )
        )
        
        let status = GRPCStatus(code: .cancelled, message: nil)
        store.assert(
            .send(.grpcError(status)) {
                $0.alert = AlertState(
                    title: "GRPC Error Code: \(status.code)",
                    message: "description: \(status.code) (\(status.code.rawValue))",
                    dismissButton: .default("OK", send: .alertDismissed)
                )
            },
            .send(.alertDismissed) {
                $0.alert = nil
            }
        )
    }
    
    func testActionSheetDismissed() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionClient: .mock
            )
        )
        
        store.assert(
            .send(.sortOptionTapped) {
                $0.actionSheet = ActionSheetState(
                    title: "Change sorting option",
                    buttons: [
                        .default("Number", send: .sortOptionChanged(.number)),
                        .default("Title", send: .sortOptionChanged(.alphabet)),
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
                laguSionClient: .mock
            )
        )

        store.assert(
            .send(.sortOptionTapped) {
                $0.actionSheet = ActionSheetState(
                    title: "Change sorting option",
                    buttons: [
                        .default("Number", send: .sortOptionChanged(.number)),
                        .default("Title", send: .sortOptionChanged(.alphabet)),
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
            .receive(.listAllRequestCompleted([])) {
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
                laguSionClient: .mock
            )
        )
        
        store.assert(
            .send(.sortOptionTapped) {
                $0.actionSheet = ActionSheetState(
                    title: "Change sorting option",
                    buttons: [
                        .default("Number", send: .sortOptionChanged(.number)),
                        .default("Title", send: .sortOptionChanged(.alphabet)),
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
            .receive(.listAllRequestCompleted([])) {
                $0.songs = []
            }
        )
    }
}
