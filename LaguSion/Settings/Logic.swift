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

public enum ContentSizeSelection: String, CaseIterable {
    case small = "Small"
    case normal = "Normal"
    case large = "Large"
    case extraLarge = "Extra Large"
    case extraExtraLarge = "Extra Extra Large"
    
    public var contentSize: ContentSizeCategory {
        switch self {
        case .small:
            return .medium
        case .normal:
            return .large
        case .large:
            return .extraLarge
        case .extraLarge:
            return .extraExtraLarge
        case .extraExtraLarge:
            return .extraExtraExtraLarge
        }
    }
}

public struct SettingsState: Equatable {
    public var isAvailableOffline: Bool
    public var fontSelection: FontSelection
    public var contentSizeSelection: ContentSizeSelection
    
    public init(
        isAvailableOffline: Bool = false,
        fontSelection: FontSelection = .normal,
        contentSizeSelection: ContentSizeSelection = .normal
    ) {
        self.isAvailableOffline = isAvailableOffline
        self.fontSelection = fontSelection
        self.contentSizeSelection = contentSizeSelection
    }
}

public enum SettingsAction {
    case fontSelectionChanged(FontSelection)
    case contentSizeSelectionChanged(ContentSizeSelection)
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
        
        case .contentSizeSelectionChanged(let contentSizeSelection):
            state.contentSizeSelection = contentSizeSelection
            return .none
        }
    }
)
