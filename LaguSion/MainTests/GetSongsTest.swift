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
    let uuidString = "DEADBEEF-DEAD-BEEF-DEAD-DEADDEADBEEF"
    let scheduler = DispatchQueue.testScheduler
    
    func testGetSongsEmpty() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionClient: LaguSionClient.mock
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
        let response = Lagusion_ListSongResponse.with {
            $0.songs = [
                Lagusion_Song.with {
                    $0.id = Lagusion_UUID.with { $0.value = self.uuidString }
                    $0.number = 1
                    $0.title = "Di Hadapan Hadirat-Mu"
                    $0.verses = [
                        Lagusion_Verse.with {
                            $0.contents = "Di hadapan hadirat-Mu\nKami umat-Mu menyembah\nMengakui Engkau Tuhan\nAllah kekal, Maha kuasa"
                        },
                        Lagusion_Verse.with {
                            $0.contents = "Dari debu dan tanahlah\nkita dijadikan Tuhan\nDan bila tersesat kita\nTuhan tak akan tinggalkan"
                        },
                        Lagusion_Verse.with {
                            $0.contents =
                                "Kuasa serta kasih Allah\nMemenuhi seg’nap dunia\nTetap teguhlah firman-Nya\nHingga penuh hadirat-Nya"
                        },
                        Lagusion_Verse.with {
                            $0.contents = "Di pintu Surga yang suci\nmenyanyi beribu lidah\nPada Tuhan kita puji\nSekarang dan selamanya"
                        }
                    ]
                    $0.reff = Lagusion_Verse()
                    $0.book = Lagusion_Book.with {
                        $0.id = 0
                        $0.shortName = "LS"
                        $0.longName = "Lagu Sion"
                    }
                }
            ]
        }
        
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionClient: LaguSionClient { _ in
                    return AnyPublisher(
                        Just(response)
                            .setFailureType(to: GRPCStatus.self)
                    )
                }
            )
        )
        
        let songs = [
            Song(
                id: UUID(uuidString: self.uuidString)!,
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
                laguSionClient: LaguSionClient.mock
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
    
    func testGRPCError() {
        let status = GRPCStatus(code: .cancelled, message: nil)
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                laguSionClient: LaguSionClient { _ in
                    return AnyPublisher(
                            Fail(outputType: Lagusion_ListSongResponse.self, failure: status
                        )
                    )
                }
            )
        )
    
        store.assert(
            .send(.getSongs),
            .do { self.scheduler.advance(by: 0.21) },
            .receive(.grpcError(status)) {
                $0.alert = AlertState(
                    title: "GRPC Error Code: \(status.code)",
                    message: "description: \(status.code) (\(status.code.rawValue))",
                    dismissButton: .default("OK", send: .alertDismissed)
                )
            },
            .send(.alertDismissed) {
                $0.alert = nil
            }
        )
    }
}
