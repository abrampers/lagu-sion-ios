//
//  BookSelection.swift
//  DataSource
//
//  Created by Abram Perdanaputra on 30/09/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import SwiftUI

public enum BookSelection: Hashable, Equatable {
    public var string: String {
        switch self {
        case .all:
            return "All"
        case .songBook(let book):
            return book.prefix
        }
    }
    
    public var protoID: UInt32 {
        switch self {
        case .all:
            return 0
        case .songBook(let book):
            return book.protoID
        }
    }
    
    public var localizedIdentifier: LocalizedStringKey {
        LocalizedStringKey(self.string)
    }
    
    case all
    case songBook(SongBook)
}

extension BookSelection: CaseIterable {
    public static var allCases: [BookSelection] {
        [.all, .songBook(.laguSion), .songBook(.laguSionEdisiLengkap)]
    }
}
