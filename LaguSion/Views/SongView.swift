//
//  SongView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 21/05/20.
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
    case addToFavorites
}

struct SongEnvironment {
    
}

let songReducer = Reducer<Song, SongAction, SongEnvironment> { state, action, environment in
    switch action {
    case .addToFavorites:
        state.isFavorite.toggle()
        return .none
    }
}

struct SongView: View {
    let store: Store<Song, SongAction>
    
    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                Text("SongView")
                    .navigationBarTitle("\(viewStore.number) \(viewStore.title)")
                    .navigationBarItems(trailing: Button(action: { viewStore.send(.addToFavorites) }) {
                        Image(systemName: viewStore.isFavorite ? "heart.fill" : "heart")
                    })
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

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(store: Store(
            initialState: Song(id: UUID(), isFavorite: false, number: 1, title: "No 1"),
            reducer: songReducer,
            environment: SongEnvironment())
        )
    }
}
