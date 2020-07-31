//
//  SongView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 21/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
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
    
    public var localizedPrefix: LocalizedStringKey {
        LocalizedStringKey(self.prefix)
    }
    
    public var localizedName: LocalizedStringKey {
        LocalizedStringKey(self.name)
    }
    
    public var proto: Lagusion_SongBook {
        switch self {
        case .laguSion:
            return .laguSion
        case .laguSionEdisiLengkap:
            return .laguSionEdisiLengkap
        }
    }
    
    public static func proto(pbSongBook: Lagusion_SongBook) -> SongBook {
        switch pbSongBook {
        case .laguSion:
            return .laguSion
        case .laguSionEdisiLengkap:
            return .laguSionEdisiLengkap
        default:
            // MARK: TODO do some workaround if there's unexpected songbook
            return .laguSion
        }
    }
    
    case laguSion
    case laguSionEdisiLengkap
}

public struct Song: Equatable, Identifiable {
    public static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var id: UInt32
    public var isFavorite: Bool
    var number: Int
    var title: String
    var verses: [Verse]
    var reff: Verse?
    public var songBook: SongBook
    
    public init(id: UInt32, number: Int, title: String, verses: [Verse], reff: Verse? = nil, songBook: SongBook) {
        self.id = id
        self.isFavorite = false
        self.number = number
        self.title = title
        self.verses = verses
        self.reff = reff
        self.songBook = songBook
    }
    
    public init(pbSong: Lagusion_Song) {
        self.id = pbSong.id
        self.number = Int(pbSong.number)
        self.title = pbSong.title
        self.verses = pbSong.verses.map { Verse(pbVerse: $0) }
        self.reff = Verse(pbVerse: pbSong.reff)
        self.songBook = SongBook.proto(pbSongBook: pbSong.songBook)
        
        // MARK: TODO get isFavorite data locally
        self.isFavorite = false
    }
}

public struct Verse {
    var contents: [String]
    
    public init(contents: [String]) {
        self.contents = contents
    }
    
    public init(pbVerse: Lagusion_Verse) {
        self.contents = pbVerse.contents
    }
}

public enum SongAction: Equatable {
    case heartTapped
    case removeFromFavorites(Song)
    case addToFavorites(Song)
}

public struct SongEnvironment {
    public init() {}
}

public let songReducer = Reducer<Song, SongAction, SongEnvironment> { state, action, environment in
    switch action {
    case .heartTapped:
        state.isFavorite.toggle()
        if state.isFavorite {
            return Effect(value: SongAction.addToFavorites(state))
        } else {
            return Effect(value: SongAction.removeFromFavorites(state))
        }
    case .addToFavorites(_), .removeFromFavorites(_):
        return .none
    }
}
