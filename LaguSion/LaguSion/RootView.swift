//
//  RootView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import Favorites
import Main
import Networking
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
    var mainIsPresentingActionSheet: Bool = false
}

enum AppAction {
    case main(MainAction)
    case favorites(FavoritesAction)
}

struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var laguSionClient: LaguSionClientProtocol
}

extension AppState {
    var mainView: MainState {
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
    
    var favoritesView: FavoritesState {
        get {
            FavoritesState(songs: self.songs, favoriteSongs: self.favoriteSongs)
        }
        set {
            self.songs = newValue.songs
            self.favoriteSongs = newValue.favoriteSongs
        }
    }
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .combine(
    mainReducer.pullback(
        state: \AppState.mainView,
        action: /AppAction.main,
        environment: { env in
            MainEnvironment(
                mainQueue: env.mainQueue,
                laguSionClient: env.laguSionClient
            )
        }
    ),
    favoritesReducer.pullback(
        state: \AppState.favoritesView,
        action: /AppAction.favorites,
        environment: { _ in FavoritesEnvironment() }
    )
)
