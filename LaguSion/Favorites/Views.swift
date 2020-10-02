//
//  Views.swift
//  Favorites
//
//  Created by Abram Situmorang on 31/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import DataSource
import Song
import SwiftUI

public struct FavoritesView: View {
    private let store: Store<FavoritesState, FavoritesAction>
    
    public init(store: Store<FavoritesState, FavoritesAction>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                if viewStore.favoriteSongsState.isEmpty {
                    Text("You have no favorite songs")
                } else {
                    List {
                        ForEachStore(
                            self.store.scope(state: \.favoriteSongsState, action: FavoritesAction.song(index:action:))
                        ) { songViewStore in
                            NavigationLink(destination: SongView(store: songViewStore, enableFavoriteButton: false)) {
                                SongRowView(store: songViewStore)
                            }
                        }
                        .onDelete { indexSet in
                            viewStore.send(.deleteFavoriteSongs(indexSet))
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Favorites"))
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(store: Store(
            initialState: FavoritesState(
                songs: [
                    Song(id: UUID(), number: 1, title: "No 1", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 2, title: "No 2", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 9, title: "No 9", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion)
                ],
                favoriteSongs: [
                    Song(id: UUID(), number: 1, title: "No 1", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 2, title: "No 2", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                    Song(id: UUID(), number: 9, title: "No 9", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion)
                ]
            ),
            reducer: favoritesReducer,
            environment: FavoritesEnvironment())
        )
    }
}
