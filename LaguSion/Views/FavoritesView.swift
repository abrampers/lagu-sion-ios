//
//  FavoritesView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 21/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct FavoritesState {
}

enum FavoritesAction {
}

struct FavoritesEnvironment {
}

let favoritesReducer = Reducer<FavoritesState, FavoritesAction, FavoritesEnvironment> { (state, action, environment) -> Effect<FavoritesAction, Never> in
    switch action {
    }
}


struct FavoritesView: View {
    let store: Store<FavoritesState, FavoritesAction>
    
    var body: some View {
        Text("FavoritesView")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(store: Store(
            initialState: FavoritesState(),
            reducer: favoritesReducer,
            environment: FavoritesEnvironment())
        )
    }
}
