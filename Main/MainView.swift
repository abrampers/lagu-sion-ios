//
//  MainView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import CombineGRPC
import GRPC
import Networking
import Song

import SwiftUI

public enum BookSelection: Hashable, Equatable {
    public var bookIdentifier: LocalizedStringKey {
        switch self {
        case .all:
            return "All"
        case .songBook(let book):
            return book.localizedSongPrefix
        }
    }
    
    public var proto: Lagusion_SongBook {
        switch self {
        case .all:
            return .all
        case .songBook(let book):
            return book.proto
        }
    }
    
    case all
    case songBook(SongBook)
}

extension BookSelection: CaseIterable {
    public static var allCases: [BookSelection] {
        [.all, .songBook(.laguSion), .songBook(.laguSionEdisiLengkap)]
    }
}

public enum SortOptions: Hashable, CaseIterable, Equatable {
    public var localizedString: LocalizedStringKey {
        switch self {
        case .number:
            return "Song Number"
        case .alphabet:
            return "Song Title"
        }
    }
    
    public var proto: Lagusion_SortOptions {
        switch self {
        case .number:
            return .number
        case .alphabet:
            return .alphabet
        }
    }
    
    public var image: Image {
        switch self {
        case .number:
            return Image(systemName: "number.square")
        case .alphabet:
            return Image(systemName: "a.square")
        }
    }
    
    case number
    case alphabet
}

public struct MainState: Equatable {
    public var songs: [Song] = []
    public var favoriteSongs: [Song] = []
    public var selectedBook: BookSelection = .all
    public var searchQuery: String = ""
    public var selectedSortOption: SortOptions = .number
    public var actionSheet: ActionSheetState<MainAction>?
    
    public init(songs: [Song], favoriteSongs: [Song], selectedBook: BookSelection, searchQuery: String, selectedSortOptions: SortOptions) {
        self.songs = songs
        self.favoriteSongs = favoriteSongs
        self.selectedBook = selectedBook
        self.searchQuery = searchQuery
        self.selectedSortOption = selectedSortOptions
        self.actionSheet = nil
    }
}

public enum MainAction: Equatable {
    case actionSheetDismissed
    case appear
    case getSongs
    case error(GRPCStatus)
    case listAllRequestCompleted([Song])
    case searchQueryChanged(String)
    case song(index: Int, action: SongAction)
    case songBookPicked(BookSelection)
    case sortOptionChanged(SortOptions)
    case sortOptionTapped
}

public struct MainEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var grpc: GRPCExecutor
    var laguSionClient: Lagusion_LaguSionServiceClientProtocol
    
    public init(mainQueue: AnySchedulerOf<DispatchQueue>, grpc: GRPCExecutor, laguSionClient: Lagusion_LaguSionServiceClientProtocol) {
        self.mainQueue = mainQueue
        self.grpc = grpc
        self.laguSionClient = laguSionClient
    }
}

public let mainReducer: Reducer<MainState, MainAction, MainEnvironment> = .combine(
    songReducer.forEach(
        state: \MainState.songs,
        action: /MainAction.song(index:action:),
        environment: { _ in SongEnvironment() }
    ),
    Reducer { (state, action, environment) in
        switch action {
        case .actionSheetDismissed:
            state.actionSheet = nil
            return .none
            
        case .appear:
            return Effect(value: MainAction.getSongs)
        
        // MARK: TODO add alert to display error
        case .error(_):
            return .none
            
        case .getSongs:
            struct ListSongRequestCancelId: Hashable {}
            let request = Lagusion_ListSongRequest.with {
                $0.songBook = state.selectedBook.proto
                $0.sortOptions = state.selectedSortOption.proto
            }
            return Effect(environment.grpc.call(environment.laguSionClient.listSongs)(request))
                .debounce(id: ListSongRequestCancelId(), for: 0.2, scheduler: environment.mainQueue)
                .map { (response) -> [Song] in
                    return response.songs.map { Song(pbSong: $0) }
                }
                .map { (song) -> MainAction in
                    return MainAction.listAllRequestCompleted(song)
                }
                .catch { (grpcStatus) -> Effect<MainAction, Never> in
                    return Effect(value: MainAction.error(grpcStatus))
                }
                .flatMap { (action) -> Effect<MainAction, Never> in
                    return Effect(value: action)
                }
                .receive(on: environment.mainQueue)
                .eraseToEffect()
            
        case .listAllRequestCompleted(let songs):
            state.songs = songs
            return .none
            
        case .searchQueryChanged(let query):
            state.searchQuery = query
            return .none
            
        case .song(index: _, action: .addToFavorites(let addedSong)):
            if !state.favoriteSongs.contains(addedSong) {
                state.favoriteSongs.append(addedSong)
            }
            return .none
        
        case .song(index: _, action: .removeFromFavorites(let removedSong)):
            state.favoriteSongs.removeAll { $0 == removedSong }
            return .none
        
        case .song(index: _, action: _):
            return .none
            
        case .songBookPicked(let songBook):
            state.selectedBook = songBook
            return Effect(value: MainAction.getSongs)
            
        case .sortOptionChanged(let sortOption):
            state.selectedSortOption = sortOption
            state.actionSheet = nil
            return Effect(value: MainAction.getSongs)
            
        case .sortOptionTapped:
            state.actionSheet = ActionSheetState(
                title: "Change sorting option",
                buttons: [
                    .default("Number", send: .sortOptionChanged(.number)),
                    .default("Title", send: .sortOptionChanged(.alphabet)),
                    .cancel()
                ]
            )
            return .none
        }
    }
)

internal struct HeaderView: View {
    internal let store: Store<MainState, MainAction>
    @State private var hideNavBar: Bool = false
    
    internal var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                WithViewStore(self.store.scope(state: { $0.selectedBook }, action: MainAction.songBookPicked)) {
                    selectedBookViewStore in
                    Picker(
                        "Selected Book", selection: selectedBookViewStore.binding(send: { $0 })
                    ) {
                        ForEach(BookSelection.allCases, id: \.self) { bookSelection in
                            Text(bookSelection.bookIdentifier).tag(bookSelection)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                SearchField(text: viewStore.binding(
                    get: { $0.searchQuery }, send: MainAction.searchQueryChanged
                ))
            }
        }
    }
}

public struct MainView: View {
//    @State private var presentActionSheet: Bool = false
    private let store: Store<MainState, MainAction>
    
    public init(store: Store<MainState, MainAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    Section(header: HeaderView(store: self.store)) {
                        ForEachStore(
                            self.store.scope(state: \.songs, action: MainAction.song(index:action:))
                        ) { songViewStore in
                            NavigationLink(destination: SongView(store: songViewStore, enableFavoriteButton: true)) {
                                SongRowView(store: songViewStore)
                            }
                        }
                    }
                    .listRowBackground(Color(.systemBackground))
                }
                .listStyle(GroupedListStyle())
                .modifier(DismissingKeyboardOnSwipe())
                .navigationBarTitle("Lagu Sion")
                .animation(.default)
                .navigationBarItems(trailing:
                    Button(action: { viewStore.send(.sortOptionTapped) }) { viewStore.selectedSortOption.image }
                        .actionSheet(self.store.scope(state: { $0.actionSheet }), dismiss: .actionSheetDismissed)
//                    Button(action: { self.presentActionSheet = true }) { viewStore.selectedSortOption.image }
//                        .actionSheet(isPresented: self.$presentActionSheet) {
//                            ActionSheet(
//                                title: Text("haha"),
//                                message: Text("hihii"),
//                                buttons: [
//                                    .default(Text("HAHA")) {
//                                        self.presentActionSheet = false
//                                    },
//                                    .default(Text("HIHI")) {
//                                        self.presentActionSheet = false
//                                    },
//                                    .cancel {
//                                        self.presentActionSheet = false
//                                    }
//                                ]
//                            )
//                    }
                )
            }
            .onAppear(perform: { viewStore.send(.appear) })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(store: Store(
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
            environment: MainEnvironment(mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                                         grpc: GRPCExecutor(),
                                         laguSionClient: Lagusion_LaguSionServiceTestClient()))
        )
    }
}
