//
//  RootView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct AppState: Equatable {
    var songs: [Song] = []
}

enum AppAction {
    case main(MainAction)
}

struct AppEnvironment {
    
}

extension AppState {
    var mainView: MainState {
        get {
            MainState(songs: self.songs)
        }
        set {
            self.songs = newValue.songs
        }
    }
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .combine(
    mainReducer.pullback(
        state: \AppState.mainView,
        action: /AppAction.main,
        environment: { _ in MainEnvironment() })
)

struct RootView: View {
    let store: Store<AppState, AppAction>
    @State var selection: Int = 0
 
    var body: some View {
        TabView(selection: $selection) {
            MainView(store: self.store.scope(
                    state: { MainState(songs: $0.songs) },
                    action: { .main($0) }
                )
            )
                    .tabItem {
                        VStack {
                            Image(systemName: "globe")
                            Text("Main")
                        }
                    }
                TestCombineGRPCView()
                    .tabItem {
                        VStack {
                            Image(systemName: "globe")
                            Text("CombineGRPC")
                        }
                    }
                Text("First View")
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image("first")
                            Text("First")
                        }
                    }
            
                Text("Second View")
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image("second")
                            Text("Second")
                        }
                    }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Store(
                initialState: AppState(
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
                reducer: appReducer,
                environment: AppEnvironment()
            )
        )
    }
}
