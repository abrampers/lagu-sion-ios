//
//  SongBook.swift
//  Datasource
//
//  Created by Abram Situmorang on 27/09/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Networking
import SwiftUI

public enum SongBook: CaseIterable, Hashable {
    public var prefix: String {
        switch self {
        case .laguSion:
            return "LS"
        case .laguSionEdisiLengkap:
            return "LSEL"
        }
    }
    
    public var name: String {
        switch self {
        case .laguSion:
            return "Lagu Sion"
        case .laguSionEdisiLengkap:
            return "Lagu Sion Edisi Lengkap"
        }
    }
    
    public var protoID: UInt32 {
        switch self {
        case .laguSion:
            return 1
        case .laguSionEdisiLengkap:
            return 2
        }
    }
    
    public var localizedPrefix: LocalizedStringKey {
        LocalizedStringKey(self.prefix)
    }
    
    public var localizedName: LocalizedStringKey {
        LocalizedStringKey(self.name)
    }
    
    public static func proto(pbSongBook: Lagusion_Book) -> SongBook {
        switch pbSongBook.shortName {
        case "LS":
            return .laguSion
        case "LSEL":
            return .laguSionEdisiLengkap
        default:
            return .laguSion
        }
    }
    
    case laguSion
    case laguSionEdisiLengkap
}
