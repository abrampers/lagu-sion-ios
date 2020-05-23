//
//  MainView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct MainState: Equatable {
    var songs: [Song] = []
    var favoriteSongs: [Song] = []
}

enum MainAction {
    case song(index: Int, action: SongAction)
}

struct MainEnvironment {
}

let mainReducer: Reducer<MainState, MainAction, MainEnvironment> = .combine(
    songReducer.forEach(
        state: \MainState.songs,
        action: /MainAction.song(index:action:),
        environment: { _ in SongEnvironment() }
    ).debug(),
    Reducer { (state, action, environment) in
        switch action {
        case .song(index: let idx, action: .heartTapped):
            if state.songs[idx].isFavorite {
                state.favoriteSongs.append(state.songs[idx])
            } else {
                state.favoriteSongs.remove(at: idx)
            }
            return .none
        }
    }
)

struct MainView: View {
    let store: Store<MainState, MainAction>
    
    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                List {
                    ForEachStore(
                        self.store.scope(state: \.songs, action: MainAction.song(index:action:))
                    ) { songViewStore in
                        NavigationLink(destination: SongView(store: songViewStore, enableFavoriteButton: true)) {
                            SongTabView(store: songViewStore)
                        }
                    }
                }
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
            reducer: mainReducer,
            environment: MainEnvironment())
        )
    }
}
