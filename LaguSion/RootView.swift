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
import Song

import SwiftUI

struct AppState: Equatable {
    var songs: [Song] = []
    var favoriteSongs: [Song] = []
    var selectedBook: SongBook = .laguSion
    var searchQuery: String = ""
}

enum AppAction {
    case main(MainAction)
    case favorites(FavoritesAction)
}

struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

extension AppState {
    var mainView: MainState {
        get {
            MainState(songs: self.songs, favoriteSongs: self.favoriteSongs, selectedBook: self.selectedBook, searchQuery: self.searchQuery)
        }
        set {
            self.songs = newValue.songs
            self.favoriteSongs = newValue.favoriteSongs
            self.selectedBook = newValue.selectedBook
            self.searchQuery = newValue.searchQuery
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
        environment: { env in MainEnvironment(mainQueue: env.mainQueue) }
    ),
    favoritesReducer.pullback(
        state: \AppState.favoritesView,
        action: /AppAction.favorites,
        environment: { _ in FavoritesEnvironment() }
    )
)

struct RootView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        TabView {
            MainView(store: self.store.scope(
                state: \.mainView,
                action: AppAction.main)
            )
                .tabItem {
                    VStack {
                        Image(systemName: "globe")
                        Text("Main")
                    }
            }
            FavoritesView(store: self.store.scope(
                state: \.favoritesView,
                action: AppAction.favorites)
            )
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Favorites")
                    }
            }
            Text("Settings")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: Store(
                initialState: AppState(
                    songs: [
                        Song(id: UUID(), isFavorite: false, number: 1, title: "No 1", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                        Song(id: UUID(), isFavorite: false, number: 2, title: "No 2", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                        Song(id: UUID(), isFavorite: false, number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                        Song(id: UUID(), isFavorite: false, number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                        Song(id: UUID(), isFavorite: false, number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                        Song(id: UUID(), isFavorite: false, number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                        Song(id: UUID(), isFavorite: false, number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                        Song(id: UUID(), isFavorite: false, number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])], isLaguSion: true),
                        Song(id: UUID(), isFavorite: false, number: 9, title: "No 9", verses: [Verse(contents: ["HAHA"])], isLaguSion: true)
                    ]
                ),
                reducer: appReducer,
                environment: AppEnvironment(mainQueue: DispatchQueue.main.eraseToAnyScheduler())
            )
        )
    }
}
