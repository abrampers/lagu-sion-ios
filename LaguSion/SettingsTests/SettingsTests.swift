//
//  SettingsTests.swift
//  SettingsTests
//
//  Created by Abram Situmorang on 31/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture

import XCTest
@testable import Settings

class SettingsTests: XCTestCase {
    func testChangeFontSelection() {
        let store = TestStore(
            initialState: SettingsState(isAvailableOffline: false, fontSelection: .normal, contentSizeSelection: .normal),
            reducer: settingsReducer,
            environment: SettingsEnvironment()
        )
        
        store.assert(
            .send(.fontSelectionChanged(.avenir)) {
                $0.fontSelection = .avenir
            }
        )
    }
    
    func testChangeContentSizeSelection() {
        let store = TestStore(
            initialState: SettingsState(isAvailableOffline: false, fontSelection: .normal, contentSizeSelection: .normal),
            reducer: settingsReducer,
            environment: SettingsEnvironment()
        )
        
        store.assert(
            .send(.contentSizeSelectionChanged(.large)) {
                $0.contentSizeSelection = .large
            }
        )
    }
}
