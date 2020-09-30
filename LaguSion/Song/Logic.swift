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

public enum SongAction: Equatable {
    case heartTapped
    case removeFromFavorites
    case addToFavorites
}

public struct SongEnvironment {
    public init() {}
}

public let songReducer = Reducer<Song, SongAction, SongEnvironment> { state, action, environment in
    switch action {
    case .heartTapped:
        state.isFavorite.toggle()
        if state.isFavorite {
            return Effect(value: SongAction.addToFavorites)
        } else {
            return Effect(value: SongAction.removeFromFavorites)
        }
    case .addToFavorites, .removeFromFavorites:
        return .none
    }
}
