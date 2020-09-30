//
//  Views.swift
//  LaguSion
//
//  Created by Abram Situmorang on 31/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import DataSource
import Favorites
import Main
import Settings
import Song
import SwiftUI

struct FontModifier: ViewModifier {
    var font: Font?
    
    func body(content: Content) -> some View {
        content
            .font(font)
    }
}

struct RootView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            TabView {
                MainView(store:
                    self.store.scope(state: \.main, action: AppAction.main)
                )
                    .tabItem {
                        VStack {
                            Image(systemName: "globe")
                            Text("Lagu Sion")
                        }
                }
                FavoritesView(store: self.store.scope(
                    state: \.favorites, action: AppAction.favorites)
                )
                    .tabItem {
                        VStack {
                            Image(systemName: "star.fill")
                            Text("Favorites")
                        }
                }
                SettingsView(store:
                    self.store.scope(state: \.settings, action: AppAction.settings)
                )
                    .tabItem {
                        VStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                }
            }
            .environment(\.font, viewStore.fontSelection.font)
            .environment(\.sizeCategory, viewStore.contentSizeSelection.contentSize)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: Store(
                initialState: AppState(
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
                    ]
                ),
                reducer: appReducer,
                environment: AppEnvironment(
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                    laguSionDataSource: MockLaguSionDataSource()
                )
            )
        )
    }
}
