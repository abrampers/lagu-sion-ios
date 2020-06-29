//
//  MainView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import Song

import SwiftUI

public enum SongBook: LocalizedStringKey, CaseIterable, Hashable {
    case laguSion = "Lagu Sion"
    case laguSionEdisiLengkap = "Lagu Sion Edisi Lengkap"
}

public struct MainState: Equatable {
    public var songs: [Song] = []
    public var favoriteSongs: [Song] = []
    public var selectedBook: SongBook = .laguSion
    public var searchQuery: String = ""
    
    public init(songs: [Song], favoriteSongs: [Song], selectedBook: SongBook, searchQuery: String) {
        self.songs = songs
        self.favoriteSongs = favoriteSongs
        self.selectedBook = selectedBook
        self.searchQuery = searchQuery
    }
}

public enum MainAction {
    case song(index: Int, action: SongAction)
    case songBookPicked(SongBook)
    case searchQueryChanged(String)
}

public struct MainEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
    public init(mainQueue: AnySchedulerOf<DispatchQueue>) {
        self.mainQueue = mainQueue
    }
}

public let mainReducer: Reducer<MainState, MainAction, MainEnvironment> = .combine(
    songReducer.forEach(
        state: \MainState.songs,
        action: /MainAction.song(index:action:),
        environment: { _ in SongEnvironment() }
    ).debug(),
    Reducer { (state, action, environment) in
        switch action {
        case .song(index: _, action: .addToFavorites(let addedSong)):
            if !state.favoriteSongs.contains(addedSong) {
                state.favoriteSongs.append(addedSong)
            }
            return .none
            
        case .songBookPicked(let songBook):
            state.selectedBook = songBook
            return .none
            
        case .song(index: _, action: .removeFromFavorites(let removedSong)):
            state.favoriteSongs.removeAll { $0 == removedSong }
            return .none
            
        case .song(index: _, action: _):
            return .none
            
        case .searchQueryChanged(let query):
            state.searchQuery = query
            return .none
        }
    }.debug()
)

internal struct HeaderView: View {
    internal let store: Store<MainState, MainAction>
    
    internal var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                WithViewStore(self.store.scope(state: { $0.selectedBook }, action: MainAction.songBookPicked)) {
                    selectedBookViewStore in
                    Picker(
                        "Selected Book", selection: selectedBookViewStore.binding(send: { $0 })
                    ) {
                        ForEach(SongBook.allCases, id: \.self) { songBook in
                            Text(songBook.rawValue).tag(songBook)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                SearchField(searchText: viewStore.binding(
                    get: { $0.searchQuery }, send: MainAction.searchQueryChanged
                ))
            }
        }
    }
}

public struct MainView: View {
    private let store: Store<MainState, MainAction>
    
    public init(store: Store<MainState, MainAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    Section(header: HeaderView(store: self.store)) {
                        ForEachStore(
                            self.store.scope(state: \.songs, action: MainAction.song(index:action:))
                        ) { songViewStore in
                            NavigationLink(destination: SongView(store: songViewStore, enableFavoriteButton: true)) {
                                SongTabView(store: songViewStore)
                            }
                        }
                    }
                }
            .listStyle(GroupedListStyle())
                .modifier(DismissingKeyboardOnSwipe())
                .navigationBarTitle("Lagu Sion")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(store: Store(
            initialState: MainState(
                songs: [
                    Song(id: UUID(), isFavorite: false, number: 1, title: "No 1", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                    Song(id: UUID(), isFavorite: false, number: 2, title: "No 2", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                    Song(id: UUID(), isFavorite: false, number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                    Song(id: UUID(), isFavorite: false, number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                    Song(id: UUID(), isFavorite: false, number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                    Song(id: UUID(), isFavorite: false, number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                    Song(id: UUID(), isFavorite: false, number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                    Song(id: UUID(), isFavorite: false, number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                    Song(id: UUID(), isFavorite: false, number: 9, title: "No 9 HAHAHAHAHAHAHAHAHHAAHHAHHAHAHAHAHAHAHAHAHAH", verses: [Verse(contents: ["HAHA"])], isLaguSion: true)
                ], favoriteSongs: [], selectedBook: .laguSion, searchQuery: ""
            ),
            reducer: mainReducer,
            environment: MainEnvironment(mainQueue: DispatchQueue.main.eraseToAnyScheduler()))
        )
    }
}
