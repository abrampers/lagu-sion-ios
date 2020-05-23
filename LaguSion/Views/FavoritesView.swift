//
//  FavoritesView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 21/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct FavoritesState: Equatable {
    var songs: [Song] = []
    var favoriteSongs: [Song] = []
}

enum FavoritesAction {
    case song(index: Int, action: SongAction)
    case deleteFavoriteSongs(IndexSet)
}

struct FavoritesEnvironment {
}

let favoritesReducer: Reducer<FavoritesState, FavoritesAction, FavoritesEnvironment> = .combine(
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

struct FavoritesView: View {
    let store: Store<FavoritesState, FavoritesAction>
    
    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                List {
                    ForEachStore(
                        self.store.scope(state: \.favoriteSongs, action: FavoritesAction.song(index:action:))
                    ) { songViewStore in
                        NavigationLink(destination: SongView(store: songViewStore, enableFavoriteButton: false)) {
                            SongTabView(store: songViewStore)
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
                favoriteSongs: [
                    Song(id: UUID(), isFavorite: false, number: 1, title: "No 1"),
                    Song(id: UUID(), isFavorite: false, number: 2, title: "No 2"),
                    Song(id: UUID(), isFavorite: false, number: 3, title: "No 3"),
                    Song(id: UUID(), isFavorite: false, number: 4, title: "No 4"),
                    Song(id: UUID(), isFavorite: false, number: 5, title: "No 5"),
                    Song(id: UUID(), isFavorite: false, number: 6, title: "No 6"),
                    Song(id: UUID(), isFavorite: false, number: 7, title: "No 7"),
                    Song(id: UUID(), isFavorite: false, number: 8, title: "No 8"),
                    Song(id: UUID(), isFavorite: false, number: 9, title: "No 9")
                ]
            ),
            reducer: favoritesReducer,
            environment: FavoritesEnvironment())
        )
    }
}
