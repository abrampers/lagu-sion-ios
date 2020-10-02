//
//  SongView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 21/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import DataSource
import SwiftUI

public struct SongViewState: Equatable, Identifiable {
    public var id: UUID {
        return song.id
    }
    
    public var song: Song
    public var isFavorite: Bool
    
    public init(song: Song, isFavorite: Bool) {
        self.song = song
        self.isFavorite = isFavorite
    }
}

extension SongViewState {
    var number: Int { song.number }
    var title: String { song.title }
    var verses: [Verse] { song.verses }
    var reff: Verse? { song.reff }
    var prefix: String { song.prefix }
    var color: Color { song.color }
}

public enum SongAction: Equatable {
    case heartTapped
    case removeFromFavorites
    case addToFavorites
}

public struct SongEnvironment {
    public init() {}
}

public let songReducer = Reducer<SongViewState, SongAction, SongEnvironment> { state, action, environment in
    switch action {
    case .heartTapped:
        if !state.isFavorite {
            return Effect(value: SongAction.addToFavorites)
        } else {
            return Effect(value: SongAction.removeFromFavorites)
        }
        
    case .addToFavorites, .removeFromFavorites:
        return .none
    }
}
