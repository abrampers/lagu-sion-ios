//
//  FavoritesView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 21/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import Song

import SwiftUI

public struct FavoritesState: Equatable {
    public var songs: [Song] = []
    public var favoriteSongs: [Song] = []
    
    public init(songs: [Song], favoriteSongs: [Song]) {
        self.songs = songs
        self.favoriteSongs = favoriteSongs
    }
}

public enum FavoritesAction {
    case song(index: Int, action: SongAction)
    case deleteFavoriteSongs(IndexSet)
}

public struct FavoritesEnvironment {
    public init() {}
}

public let favoritesReducer: Reducer<FavoritesState, FavoritesAction, FavoritesEnvironment> = .combine(
    songReducer.forEach(
        state: \FavoritesState.favoriteSongs,
        action: /FavoritesAction.song(index:action:),
        environment: { _ in SongEnvironment() }
    ).debug(),
    Reducer { state, action, environment in
        switch action {
        case .song(index: _, action: _):
            return .none
        case .deleteFavoriteSongs(let indexSet):
            var deletedFavoriteSongs: [Song] = []
            for index in indexSet {
                deletedFavoriteSongs.append(state.favoriteSongs[index])
                state.favoriteSongs.remove(at: index)
            }
            
            for deletedSong in deletedFavoriteSongs {
                for (idx, song) in state.songs.enumerated() {
                    if deletedSong == song {
                        state.songs[idx].isFavorite = false
                    }
                }
            }
            return .none
        }
    }.debug()
)

public struct FavoritesView: View {
    private let store: Store<FavoritesState, FavoritesAction>
    
    public init(store: Store<FavoritesState, FavoritesAction>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                List {
                    ForEachStore(
                        self.store.scope(state: \.favoriteSongs, action: FavoritesAction.song(index:action:))
                    ) { songViewStore in
                        NavigationLink(destination: SongView(store: songViewStore, enableFavoriteButton: false)) {
                            SongRowView(store: songViewStore)
                        }
                    }
                    .onDelete { indexSet in
                        viewStore.send(.deleteFavoriteSongs(indexSet))
                    }
                }
                .navigationBarTitle("Favorites")
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(store: Store(
            initialState: FavoritesState(
                songs: [
                    Song(id: 1, number: 1, title: "No 1", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 2, number: 2, title: "No 2", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 3, number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 4, number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 5, number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 6, number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 7, number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 8, number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 9, number: 9, title: "No 9", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion)
                ],
                favoriteSongs: [
                    Song(id: 1, number: 1, title: "No 1", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 2, number: 2, title: "No 2", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 3, number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 4, number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 5, number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 6, number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 7, number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 8, number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: 9, number: 9, title: "No 9", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion)
                ]
            ),
            reducer: favoritesReducer,
            environment: FavoritesEnvironment())
        )
    }
}
