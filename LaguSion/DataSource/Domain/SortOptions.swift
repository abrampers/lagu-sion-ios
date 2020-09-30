//
//  SortOptions.swift
//  DataSource
//
//  Created by Abram Perdanaputra on 30/09/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Networking
import SwiftUI

public enum SortOptions: Hashable, CaseIterable, Equatable {
    public var localizedString: LocalizedStringKey {
        LocalizedStringKey(self.string)
    }
    
    public var string: String {
        switch self {
        case .number:
            return "Song Number"
        case .alphabet:
            return "Song Title"
        }
    }
    
    public var proto: Lagusion_SortOptions {
        switch self {
        case .number:
            return .number
        case .alphabet:
            return .alphabet
        }
    }
    
    public var image: Image {
        switch self {
        case .number:
            return Image(systemName: "number.square")
        case .alphabet:
            return Image(systemName: "a.square")
        }
    }
    
    case number
    case alphabet
}
