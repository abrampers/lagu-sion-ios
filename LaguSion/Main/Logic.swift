//
//  MainView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import GRPC
import Networking
import Song

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

public enum SortOptions: Hashable, CaseIterable, Equatable {
    public var localizedString: LocalizedStringKey {
        LocalizedStringKey(self.string)
    }
    
    public var string: String {
        switch self {
        case .number:
            return "Song Number"
        case .alphabet:
            return "Song Title"
        }
    }
    
    public var proto: Lagusion_SortOptions {
        switch self {
        case .number:
            return .number
        case .alphabet:
            return .alphabet
        }
    }
    
    public var image: Image {
        switch self {
        case .number:
            return Image(systemName: "number.square")
        case .alphabet:
            return Image(systemName: "a.square")
        }
    }
    
    case number
    case alphabet
}

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
    case getSongs
    case getSongsCompleted([Song])
    case grpcError(GRPCStatus)
    case saveSearchQuery(String)
    case searchQueryChanged(String)
    case song(index: Int, action: SongAction)
    case songBookPicked(BookSelection)
    case sortOptionChanged(SortOptions)
    case sortOptionTapped
}

public struct MainEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var laguSionClient: LaguSionClientProtocol
    
    public init(mainQueue: AnySchedulerOf<DispatchQueue>, laguSionClient: LaguSionClientProtocol) {
        self.mainQueue = mainQueue
        self.laguSionClient = laguSionClient
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
            let request = Lagusion_ListSongRequest.with {
                $0.bookID = state.selectedBook.protoID
                $0.sortOptions = state.selectedSortOption.proto
            }
            return environment.laguSionClient.listSongs(request).eraseToEffect()
                .debounce(id: ListSongRequestCancelId(), for: 0.2, scheduler: environment.mainQueue)
                .map { (response) -> [Song] in
                    return response.songs.map { Song(pbSong: $0) }
                }
                .map { (song) -> MainAction in
                    return MainAction.getSongsCompleted(song)
                }
                .catch { (grpcStatus) -> Effect<MainAction, Never> in
                    return Effect(value: MainAction.grpcError(grpcStatus))
                }
                .flatMap { (action) -> Effect<MainAction, Never> in
                    return Effect(value: action)
                }
                .receive(on: environment.mainQueue)
                .eraseToEffect()
            
        case .getSongsCompleted(let songs):
            state.songs = songs
            return .none
            
        case .grpcError(let grpcStatus):
            state.alert = AlertState(
                title: "GRPC Error Code: \(grpcStatus.code)",
                message: "description: \(grpcStatus.description)",
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
            if !state.favoriteSongs.contains(addedSong) {
                state.favoriteSongs.append(addedSong)
            }
            return .none
        
        case .song(index: let idx, action: .removeFromFavorites):
            let removedSong = state.currentSongs[idx]
            state.favoriteSongs.removeAll { $0 == removedSong }
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
        }
    }
)
