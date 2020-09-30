//
//  FavoritesView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 21/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import DataSource
import Song
import SwiftUI

public struct FavoritesState: Equatable {
    public var songs: [Song]
    public var favoriteSongs: [Song]
    
    public init(
        songs: [Song] = [],
        favoriteSongs: [Song] = []
    ) {
        self.songs = songs
        self.favoriteSongs = favoriteSongs
    }
}

public enum FavoritesAction: Equatable {
    case song(index: Int, action: SongAction)
    case deleteFavoriteSongs(IndexSet)
    case updateFavoriteSongs([Song])
}

public struct FavoritesEnvironment {
    public init() {}
}

public let favoritesReducer: Reducer<FavoritesState, FavoritesAction, FavoritesEnvironment> = .combine(
    songReducer.forEach(
        state: \FavoritesState.favoriteSongs,
        action: /FavoritesAction.song(index:action:),
        environment: { _ in SongEnvironment() }
    ),
    Reducer { state, action, environment in
        switch action {
        case .song(index: _, action: _):
            return .none

        case .deleteFavoriteSongs(let indexSet):
            var deletedFavoriteSongs: [Song] = []
            var favoriteSongs = state.favoriteSongs
            for index in indexSet {
                deletedFavoriteSongs.append(state.favoriteSongs[index])
                favoriteSongs = favoriteSongs.filter { $0 != favoriteSongs[index] }
            }
            
            for deletedSong in deletedFavoriteSongs {
                for (idx, song) in state.songs.enumerated() {
                    if deletedSong == song {
                        state.songs[idx].isFavorite.toggle()
                    }
                }
            }
            return Effect(value: FavoritesAction.updateFavoriteSongs(favoriteSongs))
        
        case .updateFavoriteSongs(let favoriteSongs):
            state.favoriteSongs = favoriteSongs
            return .none
        }
    }
)
