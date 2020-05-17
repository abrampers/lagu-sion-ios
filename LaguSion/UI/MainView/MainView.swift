//
//  MainView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct Song: Equatable, Identifiable {
    var id: UUID
    var isFavorite: Bool
    var number: Int
    var title: String
}

enum SongAction {
    case heartTapped
}

struct SongEnvironment {
    
}

let songReducer = Reducer<Song, SongAction, SongEnvironment> { state, action, environment in
    switch action {
    case .heartTapped:
        state.isFavorite.toggle()
        return .none
    }
}

struct MainState: Equatable {
    var songs: [Song] = []
}

enum MainAction {
    case song(index: Int, action: SongAction)
}

struct MainEnvironment {
}

let mainReducer: Reducer<MainState, MainAction, MainEnvironment> = songReducer.forEach(
  state: \MainState.songs,
  action: /MainAction.song(index:action:),
  environment: { _ in SongEnvironment() }
)
    .debug()

struct MainView: View {
    let store: Store<MainState, MainAction>
    
    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                List {
                  ForEachStore(
                    self.store.scope(state: \.songs, action: MainAction.song(index:action:))
                    ) { viewStore in
                        NavigationLink(destination: SongView(store: viewStore)) {
                            SongTabView(store: viewStore)
                        }
                    }
                }
                .navigationBarTitle("Lagu Sion")
            }
        }
    }
}

struct SongTabView: View {
    let store: Store<Song, SongAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Text("\(viewStore.number)")
                Text(viewStore.title)
            }
        }
    }
}

struct SongView: View {
    let store: Store<Song, SongAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                EmptyView()
                .navigationBarTitle("\(viewStore.number) \(viewStore.title)")
                .navigationBarItems(trailing: Button(action: { viewStore.send(.heartTapped) }) {
                    Image(systemName: viewStore.isFavorite ? "heart.fill" : "heart")
                })
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
                        Song(id: UUID(), isFavorite: false, number: 5, title: "No 5")
                    ]
                ),
                reducer: mainReducer,
                environment: MainEnvironment()
            )
        )
    }
}
