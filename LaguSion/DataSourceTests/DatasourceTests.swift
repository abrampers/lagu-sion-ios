//
//  DatasourceTests.swift
//  DatasourceTests
//
//  Created by Abram Situmorang on 27/09/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import CombineGRPC
import Foundation
import GRPC
import Networking

import XCTest
@testable import DataSource

class DatasourceTests: XCTestCase {
    var combineDisposables = [AnyCancellable]()
    let uuidString = "DEADBEEF-DEAD-BEEF-DEAD-DEADDEADBEEF"
    
    func testGetSong_Empty() {
        let dataSource = DefaultLaguSionDataSource(client: MockLaguSionGRPCClient())
        let result = Combine.CurrentValueSubject<[Song], LaguSionError>([])
        dataSource.listSongs(.all, .alphabet)
            .subscribe(result)
            .store(in: &combineDisposables)
        
        XCTAssertEqual([], result.value)
    }
    
    func testGetSong() {
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
        
        let client = MockLaguSionGRPCClient { _ in
            return AnyPublisher(
                Just(response)
                    .setFailureType(to: RPCError.self)
            )
        }
        
        let dataSource = DefaultLaguSionDataSource(client: client)
        let result = Combine.CurrentValueSubject<[Song], LaguSionError>([])
        let song = Song(
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
        
        dataSource.listSongs(.all, .alphabet)
            .subscribe(result)
            .store(in: &combineDisposables)
        
        XCTAssertEqual([song], result.value)
    }
    
    func testGRPCError() {
        let status = RPCError(status: GRPCStatus(code: .cancelled, message: nil))
        let client = MockLaguSionGRPCClient { _ in
            return AnyPublisher(
                    Fail(outputType: Lagusion_ListSongResponse.self, failure: status
                )
            )
        }
        
        let dataSource = DefaultLaguSionDataSource(client: client)
        let result = Combine.CurrentValueSubject<[Song], LaguSionError>([])
        
        dataSource.listSongs(.all, .alphabet)
            .subscribe(result)
            .store(in: &combineDisposables)
        
        XCTAssertEqual([], result.value)
    }
}
