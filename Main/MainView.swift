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

public enum BookSelection: Hashable {
    public var bookIdentifier: LocalizedStringKey {
        switch self {
        case .all:
            return "All"
        case .songBook(let book):
            return book.localizedSongPrefix
        }
    }
    
    case all
    case songBook(SongBook)
}

extension BookSelection: CaseIterable {
    public static var allCases: [BookSelection] {
        [.all, .songBook(.laguSion), .songBook(.laguSionEdisiLengkap)]
    }
}

public struct MainState: Equatable {
    public var songs: [Song] = []
    public var favoriteSongs: [Song] = []
    public var selectedBook: BookSelection = .all
    public var searchQuery: String = ""
    
    public init(songs: [Song], favoriteSongs: [Song], selectedBook: BookSelection, searchQuery: String) {
        self.songs = songs
        self.favoriteSongs = favoriteSongs
        self.selectedBook = selectedBook
        self.searchQuery = searchQuery
    }
}

public enum MainAction {
    case song(index: Int, action: SongAction)
    case songBookPicked(BookSelection)
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
        
        case .song(index: _, action: .removeFromFavorites(let removedSong)):
            state.favoriteSongs.removeAll { $0 == removedSong }
            return .none
            
        case .songBookPicked(let songBook):
            state.selectedBook = songBook
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
                        ForEach(BookSelection.allCases, id: \.self) { bookSelection in
                            Text(bookSelection.bookIdentifier).tag(bookSelection)
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
                                SongRowView(store: songViewStore)
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
                    Song(id: UUID(), number: 1, title: "No 1", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 2, title: "No 2", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 9, title: "No 9 HAHAHAHAHAHAHAHAHHAAHHAHHAHAHAHAHAHAHAHAHAH", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion)
                ], favoriteSongs: [], selectedBook: .all, searchQuery: ""
            ),
            reducer: mainReducer,
            environment: MainEnvironment(mainQueue: DispatchQueue.main.eraseToAnyScheduler()))
        )
    }
}
