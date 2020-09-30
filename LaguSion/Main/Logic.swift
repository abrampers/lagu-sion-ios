//
//  MainView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import DataSource
import GRPC
import Song
import SwiftUI

public struct MainState: Equatable {
    public var songs: [Song]
    public var favoriteSongs: [Song]
    public var selectedBook: BookSelection
    public var searchQuery: String
    public var selectedSortOption: SortOptions
    public var actionSheet: ActionSheetState<MainAction>?
    public var alert: AlertState<MainAction>?
    
    public init(
        songs: [Song] = [],
        favoriteSongs: [Song] = [],
        selectedBook: BookSelection = .all,
        searchQuery: String = "",
        selectedSortOptions: SortOptions = .number,
        actionSheet: ActionSheetState<MainAction>? = nil,
        alert: AlertState<MainAction>? = nil
    ) {
        self.songs = songs
        self.favoriteSongs = favoriteSongs
        self.selectedBook = selectedBook
        self.searchQuery = searchQuery
        self.selectedSortOption = selectedSortOptions
        self.actionSheet = actionSheet
        self.alert = alert
    }
}

extension MainState {
    var currentSongs: [Song] {
        switch selectedBook {
        case .all:
            return songs
        case .songBook(let songBook):
            return songs.filter { song in
                return song.songBook == songBook
            }
        }
    }
    
    func songs(for songBook: SongBook) -> [Song] {
        return songs.filter { song in
            song.songBook == songBook
        }
    }
}

public enum MainAction: Equatable {
    case actionSheetDismissed
    case alertDismissed
    case appear
    case error(LaguSionError)
    case getSongs
    case getSongsCompleted([Song])
    case saveSearchQuery(String)
    case searchQueryChanged(String)
    case song(index: Int, action: SongAction)
    case songBookPicked(BookSelection)
    case sortOptionChanged(SortOptions)
    case sortOptionTapped
    case updateFavoriteSongsComplete([Song])
    
    case noOp
}

public struct MainEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var laguSionDataSource: LaguSionDataSourceProtocol
    
    public init(mainQueue: AnySchedulerOf<DispatchQueue>, laguSionDataSource: LaguSionDataSourceProtocol) {
        self.mainQueue = mainQueue
        self.laguSionDataSource = laguSionDataSource
    }
}

public let mainReducer: Reducer<MainState, MainAction, MainEnvironment> = .combine(
    songReducer.forEach(
        state: \MainState.songs,
        action: /MainAction.song(index:action:),
        environment: { _ in SongEnvironment() }
    ),
    Reducer { (state, action, environment) in
        switch action {
        case .actionSheetDismissed:
            state.actionSheet = nil
            return .none
            
        case .alertDismissed:
            state.alert = nil
            return .none
            
        case .appear:
            return Effect(value: MainAction.getSongs)
            
        case .getSongs:
            struct ListSongRequestCancelId: Hashable {}
            return environment.laguSionDataSource.listSongs(state.selectedBook, state.selectedSortOption).eraseToEffect()
                .debounce(id: ListSongRequestCancelId(), for: 0.2, scheduler: environment.mainQueue)
                .map { (song) -> MainAction in
                    return MainAction.getSongsCompleted(song)
                }
                .catch { (error) -> Effect<MainAction, Never> in
                    return Effect(value: MainAction.error(error))
                }
                .flatMap { (action) -> Effect<MainAction, Never> in
                    return Effect(value: action)
                }
                .receive(on: environment.mainQueue)
                .eraseToEffect()
            
        case .getSongsCompleted(let songs):
            state.songs = songs
            return .none
            
        case .error(let error):
            state.alert = AlertState(
                title: "Error: \(error.code)",
                message: "Message: \(String(describing: error.message))",
                dismissButton: .default("OK", send: .alertDismissed)
            )
            return .none
            
        case .saveSearchQuery(let query):
            state.searchQuery = query
            return .none
            
        case .searchQueryChanged(let query):
            struct SearchQueryChangedCancelId: Hashable {}
            return Effect(value: MainAction.saveSearchQuery(query))
                .debounce(id: SearchQueryChangedCancelId(), for: 0.2, scheduler: environment.mainQueue)
            
        case .song(index: let idx, action: .addToFavorites):
            let addedSong = state.currentSongs[idx]
            var newFavorites = state.favoriteSongs
            if !newFavorites.contains(addedSong) {
                newFavorites.append(addedSong)
                return Effect(value: MainAction.updateFavoriteSongsComplete(newFavorites))
            } else {
                return Effect(value: MainAction.noOp)
            }
        
        case .song(index: let idx, action: .removeFromFavorites):
            let removedSong = state.currentSongs[idx]
            var newFavorites = state.favoriteSongs
            if newFavorites.contains(removedSong) {
                newFavorites = newFavorites.filter { $0 != removedSong }
                return Effect(value: MainAction.updateFavoriteSongsComplete(newFavorites))
            } else {
                return Effect(value: MainAction.noOp)
            }
            
        case .updateFavoriteSongsComplete(let songs):
            state.favoriteSongs = songs
            return .none
        
        case .song(index: _, action: _):
            return .none
            
        case .songBookPicked(let songBook):
            state.selectedBook = songBook
            return Effect(value: MainAction.getSongs)
            
        case .sortOptionChanged(let sortOption):
            state.selectedSortOption = sortOption
            state.actionSheet = nil
            return Effect(value: MainAction.getSongs)
            
        case .sortOptionTapped:
            var buttons = SortOptions.allCases.map { (sortOption) -> ActionSheetState<MainAction>.Button in
                .default(sortOption.string, send: .sortOptionChanged(sortOption))
            }
            buttons.append(.cancel(send: .actionSheetDismissed))
            state.actionSheet = ActionSheetState(
                title: "Change sorting option",
                buttons: buttons
            )
            return .none
            
        case .noOp:
            return .none
        }
    }
)
