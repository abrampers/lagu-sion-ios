//
//  GetSongsTest.swift
//  MainTests
//
//  Created by Abram Situmorang on 28/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import ComposableArchitecture
import DataSource
import GRPC
import Networking
import Song

import SwiftUI
import XCTest

@testable import Main

class GetSongsTest: XCTestCase {
    let scheduler = DispatchQueue.testScheduler
    
    func testGetSongsEmpty() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.getSongs),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.getSongsCompleted([])) {
                $0.songs = []
            }
        )
    }
    
    func testGetSongs() {
        let songs = [
            Song(
                id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-DEADDEADBEEF")!,
                number: 1,
                title: "Di Hadapan Hadirat-Mu",
                verses: [
                    Verse(contents: [
                        "Di hadapan hadirat-Mu",
                        "Kami umat-Mu menyembah",
                        "Mengakui Engkau Tuhan",
                        "Allah kekal, Maha kuasa"
                    ]),
                    Verse(contents: [
                        "Dari debu dan tanahlah",
                        "kita dijadikan Tuhan",
                        "Dan bila tersesat kita",
                        "Tuhan tak akan tinggalkan",
                    ]),
                    Verse(contents: [
                        "Kuasa serta kasih Allah",
                        "Memenuhi seg’nap dunia",
                        "Tetap teguhlah firman-Nya",
                        "Hingga penuh hadirat-Nya",
                    ]),
                    Verse(contents: [
                        "Di pintu Surga yang suci",
                        "menyanyi beribu lidah",
                        "Pada Tuhan kita puji",
                        "Sekarang dan selamanya",
                    ])
                ], songBook: .laguSion
            )
        ]
        
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource { (_,_) -> AnyPublisher<[Song], LaguSionError>  in
                    return Just(songs)
                        .setFailureType(to: LaguSionError.self)
                        .eraseToAnyPublisher()
                }
            )
        )
        
        store.assert(
            .send(.getSongs),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.getSongsCompleted(songs)) {
                $0.songs = songs
            }
        )
    }
    
    func testGetSongsCancelled() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionDataSource: MockLaguSionDataSource()
            )
        )
        
        store.assert(
            .send(.getSongs),
            .do { self.scheduler.advance(by: 0.11) },
            .send(.getSongs),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.getSongsCompleted([])) {
                $0.songs = []
            }
        )
    }
    
    func testError() {
            let error = LaguSionError(code: .unknownError, message: nil)
            let store = TestStore(
                initialState: MainState(),
                reducer: mainReducer,
                environment: MainEnvironment(
                    mainQueue: self.scheduler.eraseToAnyScheduler(),
                    laguSionDataSource: MockLaguSionDataSource { (_,_) -> AnyPublisher<[Song], LaguSionError> in
                        return Fail(outputType: [Song].self, failure: error)
                            .eraseToAnyPublisher()
                    }
                )
            )
        
            store.assert(
                .send(.getSongs),
                .do { self.scheduler.advance(by: 0.21) },
                .receive(.error(error)) {
                    $0.alert = AlertState(
                        title: "Error: \(error.code)",
                        message: "Message: nil",
                        dismissButton: .default("OK", send: .alertDismissed)
                    )
                },
                .send(.alertDismissed) {
                    $0.alert = nil
                }
            )
        }
}
