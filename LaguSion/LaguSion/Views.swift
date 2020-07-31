//
//  Views.swift
//  LaguSion
//
//  Created by Abram Situmorang on 31/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import Favorites
import Main
import Networking
import Song
import SwiftUI

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
                reducer: appReducer,
                environment: AppEnvironment(
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                    laguSionClient: LaguSionClient.mock
                )
            )
        )
    }
}
