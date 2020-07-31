//
//  Logic.swift
//  Settings
//
//  Created by Abram Situmorang on 31/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture

public struct SettingsState: Equatable {
}

public enum SettingsAction {
}

public struct SettingsEnvironment {
}

public let settingsReducer: Reducer<SettingsState, SettingsAction, SettingsEnvironment> = .combine(
    Reducer { (state, action, environment) in
        switch action {
        }
    }
)
