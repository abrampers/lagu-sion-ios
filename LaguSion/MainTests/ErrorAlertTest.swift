//
//  ErrorAlertTest.swift
//  MainTests
//
//  Created by Abram Perdanaputra on 01/10/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import DataSource

import XCTest
@testable import Main

class ErrorAlertTest: XCTestCase {

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
            .send(.error(LaguSionError(code: .grpcError, message: nil))) {
                $0.alert = AlertState(
                    title: "Error: 2",
                    message: "Message: nil",
                    dismissButton: .default("OK", send: .alertDismissed)
                )
            },
            .send(.alertDismissed) {
                $0.alert = nil
            }
        )
    }
}
