//
//  Constants.swift
//  Networking
//
//  Created by Abram Situmorang on 21/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import DataSource

internal class Constants {
    internal static let laguSionHost = "0.tcp.ngrok.io"
    internal static let laguSionPort = 12786
    internal static let mockedDataSource = MockLaguSionDataSource.init { bookSelection, sortOptions -> AnyPublisher<[Song], LaguSionError> in
        var songs = Constants.songs
        switch bookSelection {
        case .songBook(let songBook):
            songs = songs.filter { $0.songBook == songBook }
        default:
            break
        }
        
        switch sortOptions {
        case .alphabet:
            songs = songs.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.title <= rhs.title
            })
        case .number:
            songs = songs.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.number <= rhs.number
            })
        }
        
        return Just(songs)
            .setFailureType(to: LaguSionError.self)
            .eraseToAnyPublisher()
    }
    
    internal static let songs = [
        Song(
            id: UUID(),
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
        ),
        Song(
            id: UUID(),
            number: 2,
            title: "Hai Seg'nap Ciptaan Tuhan",
            verses: [
                Verse(contents: [
                    "Hai seg’nap ciptaan Tuhan",
                    "Nyanyikan lagu pujian",
                    "Puji Tuhan, Haleluya",
                    "Pancaran sinar mentari",
                    "Cahaya bulan berseri"
                ]),
                Verse(contents: [
                    "Desiran angin menghembus",
                    "Awan bergulung menembus",
                    "Puji Tuhan, Haleluya",
                    "Di kala fajar merekah",
                    "Dan waktu senja nyanyilah"
                ]),
                Verse(contents: [
                    "Aliran air yang jernih",
                    "Menyanyikan lagu kasih",
                    "Puji Tuhan, Haleluya",
                    "Bagai api yang membara",
                    "Dan menghangatkan udara"
                ]),
                Verse(contents: [
                    "Sembah sujudlah pada-Nya",
                    "Datang dan t’rima berkat-Nya",
                    "Puji Tuhan, Haleluya",
                    "Puji Bapa dan Putra-Nya",
                    "Puji Roh Kudus, serta-Nya"
                ]),
            ],
            reff: Verse(contents: [
                "Puji Tuhan, Puji Tuhan",
                "Haleluya, haleluya, haleluya"
            ]),
            songBook: .laguSion),
        Song(id: UUID(), number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
        Song(id: UUID(), number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
        Song(id: UUID(), number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
        Song(id: UUID(), number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
        Song(id: UUID(), number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
        Song(id: UUID(), number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
        Song(id: UUID(), number: 9, title: "No 9", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
        Song(id: UUID(), number: 1, title: "No 1", verses: [Verse(contents: ["HAHA"])], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 2, title: "No 2", verses: [Verse(contents: ["HAHA"])], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], songBook: .laguSionEdisiLengkap),
        Song(id: UUID(), number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], songBook: .laguSionEdisiLengkap)
    ]
}
