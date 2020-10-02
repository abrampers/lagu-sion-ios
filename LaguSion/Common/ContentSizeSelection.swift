//
//  ContentSizeSelection.swift
//  Common
//
//  Created by Abram Perdanaputra on 01/10/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

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
