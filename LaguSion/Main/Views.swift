//
//  Views.swift
//  Main
//
//  Created by Abram Situmorang on 31/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Common
import ComposableArchitecture
import Networking
import Song
import SwiftUI

internal struct HeaderView: View {
    internal let store: Store<MainState, MainAction>
    
    internal var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                WithViewStore(self.store.scope(state: { $0.selectedBook }, action: MainAction.songBookPicked)) {
                    selectedBookViewStore in
                    Picker(
                        "Selected Book", selection: selectedBookViewStore.binding(send: { $0 })
                    ) {
                        ForEach(BookSelection.allCases, id: \.self) { bookSelection in
                            Text(bookSelection.localizedIdentifier).tag(bookSelection)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                }
                SearchField(text: viewStore.binding(
                    get: { $0.searchQuery }, send: MainAction.searchQueryChanged
                ))
            }
        }
    }
}

public struct MainView: View {
    private let store: Store<MainState, MainAction>
    
    public init(store: Store<MainState, MainAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack {
                    HeaderView(store: self.store)
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 0, trailing: 8))
                    List {
                        if viewStore.selectedBook == .all {
                            ForEach(SongBook.allCases, id: \.self) { bookSelection in
                                Section(header: Text(bookSelection.name.localized)) {
                                    ForEachStore(
                                        self.store.scope(state: { $0.songs(for: bookSelection) }, action: MainAction.song(index:action:))
                                    ) { songViewStore in
                                        NavigationLink(destination: SongView(store: songViewStore, enableFavoriteButton: true)) {
                                            SongRowView(store: songViewStore)
                                        }
                                    }
                                }
                            }
                        } else {
                            Section(header: Text(viewStore.selectedBook.localizedIdentifier)) {
                                ForEachStore(
                                    self.store.scope(state: \.currentSongs, action: MainAction.song(index:action:))
                                ) { songViewStore in
                                    NavigationLink(destination: SongView(store: songViewStore, enableFavoriteButton: true)) {
                                        SongRowView(store: songViewStore)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .modifier(DismissingKeyboardOnSwipe())
                    .navigationBarTitle(Text("Lagu Sion"))
                    .animation(.spring())
                    .navigationBarItems(trailing:
                        Button(action: { viewStore.send(MainAction.sortOptionTapped) }) { viewStore.selectedSortOption.image }
                            .actionSheet(self.store.scope(state: \.actionSheet), dismiss: .actionSheetDismissed)
                            .alert(self.store.scope(state: \.alert), dismiss: .alertDismissed)
                    )
                }
            }
            .onAppear(perform: { viewStore.send(.appear) })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: Store(
                initialState: MainState(
                    songs: [
                        Song(id: 1, number: 1, title: "No 1", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: 2, number: 2, title: "No 2", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: 3, number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: 4, number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: 5, number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: 6, number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: 7, number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: 8, number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: 9, number: 9, title: "No 9 HAHAHAHAHAHAHAHAHHAAHHAHHAHAHAHAHAHAHAHAHAH", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion)
                    ], favoriteSongs: [], selectedBook: .all, searchQuery: "", selectedSortOptions: .number
                ),
                reducer: mainReducer,
                environment: MainEnvironment(
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                    laguSionClient: LaguSionClient.mock
                )
            )
        )
    }
}
