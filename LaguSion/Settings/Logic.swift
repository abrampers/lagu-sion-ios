//
//  Logic.swift
//  Settings
//
//  Created by Abram Situmorang on 31/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Common
import ComposableArchitecture
import SwiftUI

public struct SettingsState: Equatable {
    public var isAvailableOffline: Bool
    public var fontSelection: FontSelection
    
    public init(
        isAvailableOffline: Bool = false,
        fontSelection: FontSelection = .normal
    ) {
        self.isAvailableOffline = isAvailableOffline
        self.fontSelection = fontSelection
    }
}

public enum SettingsAction {
    case fontSelectionChanged(FontSelection)
}

public struct SettingsEnvironment {
    public init() {}
}

public let settingsReducer: Reducer<SettingsState, SettingsAction, SettingsEnvironment> = .combine(
    Reducer { (state, action, environment) in
        switch action {
        case .fontSelectionChanged(let fontSelection):
            state.fontSelection = fontSelection
            return .none
        }
    }
)
