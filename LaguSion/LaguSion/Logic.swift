//
//  RootView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Common
import ComposableArchitecture
import Favorites
import Main
import Networking
import Settings
import Song
import SwiftUI

struct AppState: Equatable {
    var songs: [Song] = []
    var favoriteSongs: [Song] = []
    var selectedBook: BookSelection = .all
    var selectedSortOptions: SortOptions = .number
    var searchQuery: String = ""
    var mainActionSheet: ActionSheetState<MainAction>? = nil
    var mainAlert: AlertState<MainAction>? = nil
    var isAvailableOffline: Bool = false
    var fontSelection: FontSelection = .normal
    var contentSizeSelection: ContentSizeSelection = .normal
}

enum AppAction {
    case main(MainAction)
    case favorites(FavoritesAction)
    case settings(SettingsAction)
}

struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var laguSionClient: LaguSionClientProtocol
}

extension AppState {
    var main: MainState {
        get {
            MainState(
                songs: self.songs,
                favoriteSongs: self.favoriteSongs,
                selectedBook: self.selectedBook,
                searchQuery: self.searchQuery,
                selectedSortOptions: self.selectedSortOptions,
                actionSheet: self.mainActionSheet,
                alert: self.mainAlert
            )
        }
        set {
            self.songs = newValue.songs
            self.favoriteSongs = newValue.favoriteSongs
            self.selectedBook = newValue.selectedBook
            self.searchQuery = newValue.searchQuery
            self.selectedSortOptions = newValue.selectedSortOption
            self.mainActionSheet = newValue.actionSheet
            self.mainAlert = newValue.alert
        }
    }
    
    var favorites: FavoritesState {
        get {
            FavoritesState(songs: self.songs, favoriteSongs: self.favoriteSongs)
        }
        set {
            self.songs = newValue.songs
            self.favoriteSongs = newValue.favoriteSongs
        }
    }
    
    var settings: SettingsState {
        get {
            SettingsState(
                isAvailableOffline: self.isAvailableOffline,
                fontSelection: self.fontSelection,
                contentSizeSelection: self.contentSizeSelection
            )
        }
        set {
            self.isAvailableOffline = newValue.isAvailableOffline
            self.fontSelection = newValue.fontSelection
            self.contentSizeSelection = newValue.contentSizeSelection
        }
    }
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .combine(
    mainReducer.pullback(
        state: \AppState.main,
        action: /AppAction.main,
        environment: { env in
            MainEnvironment(
                mainQueue: env.mainQueue,
                laguSionClient: env.laguSionClient
            )
        }
    ),
    favoritesReducer.pullback(
        state: \AppState.favorites,
        action: /AppAction.favorites,
        environment: { _ in FavoritesEnvironment() }
    ),
    settingsReducer.pullback(
        state: \AppState.settings,
        action: /AppAction.settings,
        environment: { _ in SettingsEnvironment() }
    )
)
