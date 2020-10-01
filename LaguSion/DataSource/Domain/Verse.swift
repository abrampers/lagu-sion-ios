//
//  Verse.swift
//  Datasource
//
//  Created by Abram Situmorang on 27/09/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Networking

public struct Verse: Equatable {
    private var _contents: [String]
    
    public var contents: [String] {
        get {
            return _contents
        }
    }
    
    public init(contents: [String]) {
        self._contents = contents
    }
    
    public init(pbVerse: Lagusion_Verse) {
        self._contents = pbVerse.contents.components(separatedBy: "\n")
    }
}
