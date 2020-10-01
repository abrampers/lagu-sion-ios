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
        Song(id: UUID(), number: 0, title: "", verses: [], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 1, title: "", verses: [], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 2, title: "", verses: [], songBook: .laguSionEdisiLengkap),
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
        
        var firstSongFavorited = self.songs[0]
        firstSongFavorited.isFavorite = true
        
        store.assert(
            .send(.song(index: 0, action: .addToFavorites)) {
                $0.songs[0].isFavorite = true
            },
            .receive(.updateFavoriteSongs(newFavorites: [firstSongFavorited])) {
                $0.favoriteSongs = [firstSongFavorited]
            }
        )
    }
    
    func testAddToFavorites_All_WhenExists() {
        var song = Song(id: UUID(), number: 100, title: "", verses: [], reff: nil, songBook: .laguSion)
        song.isFavorite = true
        
        let initialSongs = [song] + self.songs
        let store = TestStore(
            initialState: MainState(
                songs: initialSongs,
                favoriteSongs: initialSongs,
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
        var song = Song(id: UUID(), number: 100, title: "", verses: [], reff: nil, songBook: .laguSion)
        song.isFavorite = true
        
        let store = TestStore(
            initialState: MainState(
                songs: [song] + self.songs,
                favoriteSongs: [song],
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
            .send(.song(index: 0, action: .removeFromFavorites)) {
                $0.songs[0].isFavorite = false
            },
            .receive(.updateFavoriteSongs(newFavorites: [])) {
                $0.favoriteSongs = []
            }
        )
    }
    
    func testRemoveFromFavorites_All_WhenEmpty() {
        var song = Song(id: UUID(), number: 100, title: "", verses: [], reff: nil, songBook: .laguSion)
        song.isFavorite = true
        
        let store = TestStore(
            initialState: MainState(
                songs: [song] + self.songs,
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
            .send(.song(index: 0, action: .removeFromFavorites)) {
                $0.songs[0].isFavorite = false
            },
            .receive(.noOp)
        )
    }
    
    func testRemoveFromFavorites_All_WhenOutOfRange() {
        var song = Song(id: UUID(), number: 100, title: "", verses: [], reff: nil, songBook: .laguSion)
        song.isFavorite = true
        
        let store = TestStore(
            initialState: MainState(
                songs: [song] + self.songs,
                favoriteSongs: [song],
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
        
        var firstSongFavorited = self.songs[0]
        firstSongFavorited.isFavorite = true
        let newFavorites = [firstSongFavorited]
        
        store.assert(
            .send(.song(index: 0, action: .addToFavorites)) {
                $0.songs[0].isFavorite = true
            },
            .receive(.updateFavoriteSongs(newFavorites: newFavorites)) {
                $0.favoriteSongs = newFavorites
            }
        )
    }
    
    func testAddToFavorites_LS_WhenExists() {
        var song = Song(id: UUID(), number: 100, title: "", verses: [], reff: nil, songBook: .laguSion)
        song.isFavorite = true
        
        let store = TestStore(
            initialState: MainState(
                songs: [song] + self.songs,
                favoriteSongs: [song],
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
        var song = Song(id: UUID(), number: 100, title: "", verses: [], reff: nil, songBook: .laguSion)
        song.isFavorite = true
        
        let store = TestStore(
            initialState: MainState(
                songs: [song] + self.songs,
                favoriteSongs: [song],
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
            .send(.song(index: 0, action: .removeFromFavorites)) {
                $0.songs[0].isFavorite = false
            },
            .receive(.updateFavoriteSongs(newFavorites: [])) {
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
        
        var firstSongFavorited = self.songs[5]
        firstSongFavorited.isFavorite = true
        let newFavorites = [firstSongFavorited]
        
        store.assert(
            .send(.song(index: 0, action: .addToFavorites)) {
                $0.songs[5].isFavorite = true
            },
            .receive(.updateFavoriteSongs(newFavorites: newFavorites)) {
                $0.favoriteSongs = newFavorites
            }
        )
    }
    
    func testAddToFavorites_LSEL_WhenExists() {
        var song = Song(id: UUID(), number: 100, title: "", verses: [], reff: nil, songBook: .laguSionEdisiLengkap)
        song.isFavorite = true
        
        let initialSongs = [song] + self.songs
        let store = TestStore(
            initialState: MainState(
                songs: initialSongs,
                favoriteSongs: initialSongs,
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
        var song = Song(id: UUID(), number: 100, title: "", verses: [], reff: nil, songBook: .laguSionEdisiLengkap)
        song.isFavorite = true
        
        let store = TestStore(
            initialState: MainState(
                songs: self.songs + [song],
                favoriteSongs: [song],
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
            .send(.song(index: 3, action: .removeFromFavorites)) {
                $0.songs[8].isFavorite = false
            },
            .receive(.updateFavoriteSongs(newFavorites: [])) {
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
