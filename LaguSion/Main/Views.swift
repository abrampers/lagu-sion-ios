//
//  Views.swift
//  Main
//
//  Created by Abram Situmorang on 31/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Common
import ComposableArchitecture
import DataSource
import Song
import SwiftUI

internal struct SongHeader: View {
    internal let store: Store<MainState, MainAction>
    
    internal var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Picker(
                    "Selected Book",
                    selection: viewStore.binding(get: { $0.selectedBook }, send: { MainAction.songBookPicked($0) })
                ) {
                    ForEach(BookSelection.allCases, id: \.self) { bookSelection in
                        Text(bookSelection.localizedIdentifier).tag(bookSelection)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                SearchField(text: viewStore.binding(
                    get: { $0.searchQuery }, send: MainAction.searchQueryChanged
                ))
            }
        }
    }
}

internal struct SongList: View {
    internal let store: Store<MainState, MainAction>
    
    internal init(store: Store<MainState, MainAction>) {
        self.store = store
    }
    
    internal var body: some View {
        WithViewStore(self.store) { viewStore in
            List {
                Section {
                    SongHeader(store: self.store)
                }
                Section {
                    ForEachStore(
                        self.store.scope(state: { $0.currentSongs }, action: MainAction.song(index:action:))
                    ) { songViewStore in
                        NavigationLink(destination: SongView(store: songViewStore, enableFavoriteButton: true)) {
                            SongRowView(store: songViewStore)
                        }
                    }
                }
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
        NavigationView {
            WithViewStore(self.store) { viewStore in
                SongList(store: self.store)
                    .navigationBarItems(trailing:
                                            Button(action: { viewStore.send(MainAction.sortOptionTapped) }) { viewStore.selectedSortOption.image }
                                            .actionSheet(self.store.scope(state: \.actionSheet), dismiss: .actionSheetDismissed)
                                            .alert(self.store.scope(state: \.alert), dismiss: .alertDismissed)
                    )
                    .onAppear(perform: { viewStore.send(.appear) })
            }
            .modifier(DismissingKeyboardOnSwipe())
            .navigationBarTitle(Text("Lagu Sion"))
            .animation(.spring())
            .listStyle(PlainListStyle())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: Store(
                initialState: MainState(
                    songs: [
                        Song(id: UUID(), number: 1, title: "No 1", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: UUID(), number: 2, title: "No 2", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: UUID(), number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: UUID(), number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: UUID(), number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: UUID(), number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: UUID(), number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: UUID(), number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
                        Song(id: UUID(), number: 9, title: "No 9 HAHAHAHAHAHAHAHAHHAAHHAHHAHAHAHAHAHAHAHAHAH", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion)
                    ], favoriteSongs: [], selectedBook: .all, searchQuery: "", selectedSortOptions: .number
                ),
                reducer: mainReducer,
                environment: MainEnvironment(
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                    laguSionDataSource: MockLaguSionDataSource()
                )
            )
        )
    }
}
