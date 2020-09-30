//
//  SongTriggerTest.swift
//  MainTests
//
//  Created by Abram Perdanaputra on 30/09/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import DataSource

import XCTest
@testable import Main

class SongTriggerTest: XCTestCase {
    let scheduler = DispatchQueue.testScheduler
    let songs = [
        Song(id: UUID(), number: 0, title: "", verses: [], songBook: .laguSion),
        Song(id: UUID(), number: 1, title: "", verses: [], songBook: .laguSion),
        Song(id: UUID(), number: 2, title: "", verses: [], songBook: .laguSion),
        Song(id: UUID(), number: 3, title: "", verses: [], songBook: .laguSion),
        Song(id: UUID(), number: 4, title: "", verses: [], songBook: .laguSion),
        Song(id: UUID(), number: 1, title: "", verses: [], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 2, title: "", verses: [], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 3, title: "", verses: [], songBook: .laguSionEdisiLengkap),
    ]
    
    func testAddToFavorites_All_WhenEmpty() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: [],
                selectedBook: .all,
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        let newFavorites = [self.songs[0]]
        
        store.assert(
            .send(.song(index: 0, action: .addToFavorites)),
            .receive(.updateFavoriteSongsComplete(newFavorites)) {
                $0.favoriteSongs = newFavorites
            }
        )
    }
    
    func testAddToFavorites_All_WhenExists() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: self.songs,
                selectedBook: .all,
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.song(index: 0, action: .addToFavorites)),
            .receive(.noOp)
        )
    }
    
    func testRemoveFromFavorites_All_WhenExists() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: [self.songs[0]],
                selectedBook: .all,
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.song(index: 0, action: .removeFromFavorites)),
            .receive(.updateFavoriteSongsComplete([])) {
                $0.favoriteSongs = []
            }
        )
    }
    
    func testRemoveFromFavorites_All_WhenEmpty() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: [],
                selectedBook: .all,
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.song(index: 0, action: .removeFromFavorites)),
            .receive(.noOp)
        )
    }
    
    func testRemoveFromFavorites_All_WhenOutOfRange() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: [self.songs[0]],
                selectedBook: .all,
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.song(index: 1, action: .removeFromFavorites)),
            .receive(.noOp)
        )
    }
    
    func testAddToFavorites_LS_WhenEmpty() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: [],
                selectedBook: .songBook(.laguSion),
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        let newFavorites = [self.songs[0]]
        
        store.assert(
            .send(.song(index: 0, action: .addToFavorites)),
            .receive(.updateFavoriteSongsComplete(newFavorites)) {
                $0.favoriteSongs = newFavorites
            }
        )
    }
    
    func testAddToFavorites_LS_WhenExists() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: self.songs,
                selectedBook: .songBook(.laguSion),
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.song(index: 0, action: .addToFavorites)),
            .receive(.noOp)
        )
    }
    
    func testRemoveFromFavorites_LS_WhenExists() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: [self.songs[0]],
                selectedBook: .songBook(.laguSion),
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.song(index: 0, action: .removeFromFavorites)),
            .receive(.updateFavoriteSongsComplete([])) {
                $0.favoriteSongs = []
            }
        )
    }
    
    func testRemoveFromFavorites_LS_WhenEmpty() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: [],
                selectedBook: .songBook(.laguSion),
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.song(index: 0, action: .removeFromFavorites)),
            .receive(.noOp)
        )
    }
    
    func testAddToFavorites_LSEL_WhenEmpty() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: [],
                selectedBook: .songBook(.laguSionEdisiLengkap),
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        let newFavorites = [self.songs[5]]
        
        store.assert(
            .send(.song(index: 0, action: .addToFavorites)),
            .receive(.updateFavoriteSongsComplete(newFavorites)) {
                $0.favoriteSongs = newFavorites
            }
        )
    }
    
    func testAddToFavorites_LSEL_WhenExists() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: self.songs,
                selectedBook: .songBook(.laguSionEdisiLengkap),
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.song(index: 0, action: .addToFavorites)),
            .receive(.noOp)
        )
    }
    
    func testRemoveFromFavorites_LSEL_WhenExists() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: [self.songs[5]],
                selectedBook: .songBook(.laguSionEdisiLengkap),
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.song(index: 0, action: .removeFromFavorites)),
            .receive(.updateFavoriteSongsComplete([])) {
                $0.favoriteSongs = []
            }
        )
    }
    
    func testRemoveFromFavorites_LSEL_WhenEmpty() {
        let store = TestStore(
            initialState: MainState(
                songs: self.songs,
                favoriteSongs: [],
                selectedBook: .songBook(.laguSionEdisiLengkap),
                searchQuery: "",
                selectedSortOptions: .alphabet,
                actionSheet: nil,
                alert: nil
            ),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.song(index: 0, action: .removeFromFavorites)),
            .receive(.noOp)
        )
    }
}
